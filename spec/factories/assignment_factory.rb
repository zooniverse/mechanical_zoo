FactoryBot.define do
  sequence :assignment_id { |i| "ASSIGNMENT#{i}" }
  sequence :hit_id { |i| "HIT#{i}" }

  factory :project do
    display_name "My Project"
  end

  factory :workflow do
    project
    project_slug "foo/bar"
    hit_title "Hit Title"
    hit_description "Hit Description"
  end

  factory :workflow_subject do
    workflow
    subject_id 1
  end

  factory :hit do
    id { generate :hit_id }
    workflow_subject
  end

  factory :assignment do
    id { generate :assignment_id }
    turk_submit_to "http://example.org"
    worker_id "JKDSAYY"

    hit
  end
end
