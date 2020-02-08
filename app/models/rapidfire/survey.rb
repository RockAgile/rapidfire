module Rapidfire
  class Survey < ActiveRecord::Base
    has_many  :attempts, :dependent => :destroy
    has_many  :questions, :dependent => :destroy
    has_many :sections, :dependent => :destroy
    has_many :attempts, :dependent => :destroy

    validates :name, :presence => true
  end
end
