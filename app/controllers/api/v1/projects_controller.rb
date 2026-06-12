module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :set_workspace, only: %i[ index create ]
      before_action :set_project, only: %i[ show update destroy ]

      def index
        authorize @workspace

        @projects = @workspace.projects
        render json: @projects
      end

      def show
        authorize @project
        render json: @project
      end

      def create
        authorize @workspace, :create_project?, policy_class: Workspace
        @project = Project::CreateService.new(user: current_user, workspace: @workspace, params: project_params).call
        render json: @project, status: :created
      end

      def update
        authorize @project
        @project.update!(project_params)
        render json: @project
      end

      def destroy
        authorize @project
        @project.destroy!
        render json: "Deleted"
      end

      private

      def set_workspace
        @workspace = current_user.workspaces.find(params[:workspace_id])
      end

      def set_project
        @project = @workspace.projects.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
