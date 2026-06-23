module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_project, only: %i[ show update destroy ]

      def index
        @projects = current_user.projects
        render json: @projects
      end

      def show
        authorize @project

        render json: @project
      end

      def create
        workspace = Workspace.find(params[:project][:workspace_id])
        authorize workspace, :create_project?

        @project = Projects::CreateService.new(user: current_user, params: project_params).call
        render json: @project, status: :created
      end

      def update
        authorize @project

        @project.update!(update_params)
        render json: @project
      end

      def destroy
        authorize @project

        @project.destroy!
        head :no_content
      end

      private

      def set_project
        @project = current_user.projects.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description, :workspace_id)
      end

      def update_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
