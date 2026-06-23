module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_project
      before_action :set_task, only: %i[show update destroy]

      def index
        @tasks = @project.tasks
        render json: @tasks
      end

      def show
        render json: @task
      end

      def create
        authorize @project, :create_tasks?

        @task = @project.tasks.create!(task_params)
        render json: @task, status: :created
      end

      def update
        authorize @task

        @task.update!(task_params)
        render json: @task
      end

      def destroy
        authorize @task

        @task.destroy!
        head :no_content
      end

      private

      def set_project
        @project = current_user.projects.find(params[:project_id])
      end

      def set_task
        @task = @project.tasks.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :priority, :status, :deadline, :assignee_id)
      end
    end
  end
end
