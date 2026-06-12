module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_workspace, only: %i[ index ]
      before_action :set_project, only: %i[ show update destroy ]

      def index
        @projects = @workspace.projects
        render json: @projects
      end

      def show
        render json: @project
      end

      def create
        @project = Project::CreateService.new(user: current_user, params: project_params).call
        render json: @project, status: :created
      end

      def update
        @project.update!(workspace_params)
        render json: @project
      end

      def destroy
        @project.destroy!
        render json: "Deleted"
      end

      private

      def set_workspace
        @workspace = current_user.workspaces.find(params[:workspace_id])
      end

      def set_project
        @project = @workspace.project.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
