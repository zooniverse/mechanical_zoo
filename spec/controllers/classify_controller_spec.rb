require 'rails_helper'

describe ClassifyController, controller: true do
  describe '#callback' do
    let(:assignment) { create :assignment }

    it 'stores the classification id with the assignment' do
      get :callback, params: {id: assignment.id, classification_id: "123"}
      expect(assignment.reload.classification_id).to eq(123)
    end

    it 'prepares a job to post-process the assignment' do
      expect do
        get :callback, params: {id: assignment.id, classification_id: "123"}
      end.to change(ProcessAssignmentWorker.jobs, :size).by(1)
    end
  end
end
