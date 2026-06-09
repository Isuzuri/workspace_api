module Api
  module V1
    class MembershipsController < ApplicationController
      before_action :set_workspace, only: %i[ invite exclude change_role ]

      def invite
        authorize @workspace

        membership = @workspace.memberships.find_by(user: user)
        return membership if membership

        @workspace.memberships.create!(user: user, role: role)
      end

      def exclude
        authorize @workspace

        membership = @workspace.memberships.find_by(user: user)
        return unless membership

        membership.destroy!
      end

      def change_role
        authorize @workspace

        membership = @workspace.memberships.find_by(user: user)
        return unless membership

        membership.update!(role: role)
      end

      private 

      def set_workspace
        @workspace = current_user.workspaces.find(params[:workspace_id])
      end

      def user 
        @user ||= User.find(params[:user_id])
      end

      def role
        params[:role]
      end
    end
  end
end