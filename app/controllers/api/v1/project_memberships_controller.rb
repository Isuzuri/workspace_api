module Api
  module V1
    class ProjectMembershipsController < ApplicationController
      before_action :set_project, only: %i[ index create update destroy ]

      def index
        authorize @project
        render json: @project.project_memberships
      end

      def create
        return head :no_content if @project.project_memberships.exists?(user_id: params[:user_id])

        authorize @project

        @project.project_memberships.create!(project_memberships_params)
        head :no_content
      end

      def update
        project_membership = @project.project_memberships.find(params[:id])

        authorize project_membership

        project_membership.update!(role: params[:role])
        head :no_content
      end

      def destroy
        project_membership = @project.project_memberships.find(params[:id])

        authorize project_membership

        project_membership.destroy!
        head :no_content
      end

      private

      def set_project
        @project = current_user.projects.find(params[:project_id])
      end

      def project_membership_params
        params.require(:project_membership).permit(:user_id, :role)
      end
    end
  end
end
