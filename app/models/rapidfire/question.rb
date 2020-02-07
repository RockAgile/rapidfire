module Rapidfire
  class Question < ActiveRecord::Base
    attribute :position, :integer, default: -> { (Rapidfire::Question.maximum(:position) || 0) + 1 }

    belongs_to :survey, :inverse_of => :questions
    belongs_to :section, :inverse_of => :questions
    has_many   :answers

    default_scope { order(:position) }

    validates :survey, :question_text, :presence => true
    serialize :validation_rules

    def self.inherited(child)
      child.instance_eval do
        def model_name
          Question.model_name
        end
      end

      super
    end

    def rules
      validation_rules || {}
    end

    # answer will delegate its validation to question, and question
    # will inturn add validations on answer on the fly!
    def validate_answer(answer)
      if rules[:presence] == "1"
        answer.validates_presence_of :answer_text
      end

      if rules[:minimum].present? || rules[:maximum].present?
        min_max = { minimum: rules[:minimum].to_i }
        min_max[:maximum] = rules[:maximum].to_i if rules[:maximum].present?

        answer.validates_length_of :answer_text, min_max
      end
    end
  end
end
