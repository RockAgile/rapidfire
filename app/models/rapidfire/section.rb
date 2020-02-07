# frozen_string_literal: true

module Rapidfire
  class Section < ActiveRecord::Base
    attribute :position, :integer, default: -> { (Rapidfire::Section.maximum(:position) || 0) + 1 }

    belongs_to :survey, :inverse_of => :sections
    has_many   :questions

    default_scope { order(:position) }

    validates :survey, :presence => true
  end
end
