module Api
  module V1
    class ProjectMembershipsController < ApplicationController
      before_action :set_project, only: %i[ index create update destroy ]

      def index
        authorize @project, policy_class: ProjectMembershipsPolicy
        render json: @project.project_memberships
      end

      def create
        return head :no_content if @project.project_memberships.exists?(user_id: params[:user_id])

        authorize @project, policy_class: ProjectMembershipsPolicy

        @project.project_memberships.create!(user_id: params[:user_id], role: params[:role])
        head :no_content
      end

      def update
        project_membership = @project.project_memberships.find(params[:id])

        authorize project_membership, policy_class: ProjectMembershipsPolicy

        project_membership.update!(role: params[:role])
        head :no_content
      end

      def destroy
        project_membership = @project.project_memberships.find(params[:id])

        authorize project_membership, policy_class: ProjectMembershipsPolicy

        project_membership.destroy!
        head :no_content
      end

      private

      def set_project
        @project = current_user.projects.find(params[:project_id])
      end
    end
  end
end
