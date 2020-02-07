module Rapidfire
  class SectionsController < Rapidfire::ApplicationController
    before_action :authenticate_administrator!, except: :index
    before_action :find_survey!
    before_action :find_section!, :only => [:edit, :update, :destroy]

    def index
      @sections = if defined?(Kaminari)
        @survey.questions.page(params[:page])
      else
        @survey.questions
      end
    end

    def new
      @section = @survey.sections.new
    end

    def create
      @section = @survey.sections.new(section_params)
      if @section.save
        respond_to do |format|
          format.html { redirect_to sections_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.js
        end
      end
    end

    def edit
    end

    def update
      if @section.update(section_params)
        respond_to do |format|
          format.html { redirect_to sections_path }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.js
        end
      end
    end

    def destroy
      @section.destroy

      respond_to do |format|
        format.html { redirect_to sections_path }
        format.js
      end
    end

    private

    def find_survey!
      @survey = Survey.find(params[:survey_id])
    end

    def find_section!
      @section = @survey.sections.find(params[:id])
    end

    def section_params
      params.require(:section).permit!
    end
  end
end
