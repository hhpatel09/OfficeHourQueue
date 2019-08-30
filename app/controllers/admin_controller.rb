class AdminController < ApplicationController
  before_action :authenticate

  def index
    @users = User.get_editable_users(User.find_by(session_token: session[:session_token]).id)
    @roles = Role.all
  end

  def edit
    begin
      unless User.permission_to_edit?(User.find_by(session_token: session[:session_token]).id, params[:id])
        flash[:warning] = "You don't have permissions to edit this user"
        redirect_to admin_index_path && return
      end

      @user_to_edit = User.find(params[:id])
      @roles = Role.all
      @avail_roles = Role.get_editable_roles(User.find_by(session_token: session[:session_token]).id)
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = 'Invalid User'
      redirect_to admin_index_path
    end
  end

  def update
    # TODO: check if current user has permission to edit current user.
    new_role = params[:role_id].to_i
    if (new_role <= 0) || (new_role > Role.all.size)
      flash[:warning] = 'Invalid role_id. Not saving changes.'
      redirect_to admin_index_path && return
    end

    unless User.permission_to_edit?(User.find_by(session_token: session[:session_token]).id, params[:id])
      flash[:warning] = "You don't have permissions to edit this user"
      redirect_to admin_index_path && return
    end

    User.update_role!(params[:id], params[:role_id])
    u = User.find(params[:id])
    flash[:notice] = "Updated #{u.first_name} #{u.last_name} to be a #{Role.find(u.role_id).role_name}"
    redirect_to admin_index_path
  end

end
