# frozen_string_literal: true

# Stories Controller
class StoriesController < ApplicationController
  before_action :set_story, only: %i[show edit update destroy]
  after_action :authorize_story, only: %i[new]
  before_action :authorize_story, only: %i[edit destroy update]

  def index
    @stories = Story.all
    authorize @stories
  end

  def new
    @story = Story.new
  end

  def create
    story = Story.new(story_params)
    authorize story
    story.user_id = current_user.id
    if story.save
      redirect_to user_stories_path, notice: 'Story was successfully created.'
    else
      redirect_to current_user, notice: 'Story was not created'
    end
  end

  def edit; end

  def update
    if @story.update(story_params)
      redirect_to current_user, notice: 'Your story is updated'
    else
      redirect_to current_user, notice: 'Story was not updated'
    end
  end

  def destroy
    if @story.destroy
      redirect_to current_user, notice: 'Your story has been deleted'
    else
      redirect_to current_user, notice: 'Story was not deleted'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_story
    @story = Story.find(params[:id])
  end

  def authorize_story
    authorize @story
  end

  # Only allow a list of trusted parameters through.
  def story_params
    params.require(:story).permit(:caption, :user_id, :image)
  end
end
