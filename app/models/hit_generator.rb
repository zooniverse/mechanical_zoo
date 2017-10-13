class HitGenerator
  def initialize(workflow)
    @workflow = workflow
  end

  def generate_hits(subject_ids)
    subject_ids.map do |subject_id|
      generate_hit(subject_id)
    end
  end

  def generate_hit(subject_id)
    mturk_hit = mturk.create_hit(
      lifetime_in_seconds: 60 * 60 * 4,
      assignment_duration_in_seconds: 600,
      max_assignments: 1, # TODO
      reward: '0.25', # TODO
      title: 'ZooTurk dev integration HIT',
      description: 'Count Penguins',
      question: external_question(subject_id),
      qualification_requirements: qualifications
    )

    Hit.create! id: mturk_hit.hit_id,
                hit_type_id: mturk_hit.hit_type_id,
                hit_group_id: mturk_hit.hit_group_id,
                workflow_id: workflow.id,
                subject_id: subject_id
  end

  private

  def qualifications
    [
      # Let's exclude workers who live in California
      Aws::MTurk::Types::QualificationRequirement.new(
        qualification_type_id: '00000000000000000071',
        comparator: 'NotEqualTo',
        locale_values: [ Aws::MTurk::Types::Locale.new( country: 'US', subdivision: 'CA' ) ]
      )
    ]
  end

  def external_question(subject_id)
    xml = <<-QUESTION
      <ExternalQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2006-07-14/ExternalQuestion.xsd">
        <ExternalURL>https://7ee96f58.eu.ngrok.io/classify/start?workflow_id=#{workflow.id}&subject_id=#{subject_id}</ExternalURL>
        <FrameHeight>800</FrameHeight>
      </ExternalQuestion>
    QUESTION

    question.gsub(/\s+/, " ").strip
  end
end
