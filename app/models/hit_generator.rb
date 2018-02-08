class HitGenerator
  include ActionView::Helpers
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  attr_reader :workflow

  def initialize(workflow)
    @workflow = workflow
  end

  def generate_hits(workflow_subjects)
    workflow_subjects.map do |workflow_subject|
      generate_hit(workflow_subject)
    end
  end

  def generate_hit(workflow_subject)
    mturk_hit = mechanical_turk.create_hit(
      lifetime_in_seconds: 60 * 60 * 4,
      assignment_duration_in_seconds: 600,
      max_assignments: assignments_left(workflow_subject),
      reward: workflow.reward.to_s,
      title: workflow.hit_title,
      description: workflow.hit_description,
      question: external_question(workflow_subject),
      qualification_requirements: qualifications
    ).hit

    Hit.create! id: mturk_hit.hit_id,
                hit_type_id: mturk_hit.hit_type_id,
                hit_group_id: mturk_hit.hit_group_id,
                workflow_subject: workflow_subject
  end

  private

  def qualifications
    [
      # Let's exclude workers who live in California
      Aws::MTurk::Types::QualificationRequirement.new(
        qualification_type_id: '00000000000000000071',
        comparator: 'NotEqualTo',
        locale_values: [Aws::MTurk::Types::Locale.new(country: 'US', subdivision: 'CA')]
      )
    ]
  end

  def assignments_left(workflow_subject)
    completed_assignments = workflow_subject.assignments.complete.count
    workflow.desired_assignments - completed_assignments
  end

  def external_question(workflow_subject)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.ExternalQuestion(xmlns: "http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd") do
        xml.ExternalURL(external_url(workflow_subject))
        xml.FrameHeight(800)
      end
    end

    xml = builder.to_xml# .gsub("<?xml version=\"1.0\"?>\n", "")
    puts xml

    xml
  end

  def external_url(workflow_subject)
    # "#{Rails.application.secrets.site_domain}/turk/classify/start?workflow_id=#{workflow_subject.workflow_id}&subject_id=#{workflow_subject.subject_id}"

    url_for(host: Rails.application.secrets.app_host,
            protocol: :https,
            controller: 'classify',
            action: 'start',
            workflow_id: workflow_subject.workflow_id,
            subject_id: workflow_subject.subject_id)
  end

  def mechanical_turk
    MechanicalTurk.instance
  end
end
