# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionWithAnswersPresenter do
  subject(:presenter) { described_class.new(question, answers_survey) }

  let!(:answers_survey) { create(:answers_survey_with_some_answers) }
  let!(:survey) { answers_survey.survey }
  let!(:question) { survey.questions.first }

  describe '#correct' do
    it 'returns false when question answer contains incorrect options' do
      expect(presenter.payload[:correct]).to eq false
    end

    it 'returns true when question answer contains correct options' do
      question.options.second.update!(correct: true)
      question.options.first.update!(correct: false)
      expect(presenter.payload[:correct]).to eq true
    end
  end
end