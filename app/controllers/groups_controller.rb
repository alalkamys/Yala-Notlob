class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.all
    @group = Group.new
  end

  def new
  end

  def create
    @group = Group.new(group_params.merge(owner_id: current_user.id))

    if @group.save
      redirect_to groups_path
    else
      @groups = current_user.groups.all
      render :index
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def add_user
    @groups = current_user.groups.all
    @selected_group_id = params[:group_id]
    @selected_group = Group.find @selected_group_id
    @members = Group.find(@selected_group_id).users.all
    @member = current_user.groups.find(@selected_group_id).users.new
    @group = Group.new
  end

  def create_user
    @member = User.find(params[:user])
    @member = GroupsUser.new({ "user_id" => @member.id, "group_id" => params[:group_id] })
    if @member.save
      @member = User.find(params[:user])
      respond_to do |format|
        format.js { render partial: "javascripts/groups/create_user" }
      end
    end
  end

  def destroy_user
    GroupsUser.delete_by(user_id: params[:user_id], group_id: params[:group_id])
    @member_id = params[:user_id]
    respond_to do |format|
      format.js { render partial: "javascripts/groups/destroy_user" }
    end
    # * Or you can write it in this way, it's basically the same
    # render js: id if params[:format] == "js"
  end

  def search
    if params[:user].present?
      @group = current_user.groups.find(params[:group_id])
      @members = current_user.search(params[:user])
      if @members
        respond_to do |format|
          format.js { render partial: "javascripts/groups/member_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "User is not in your friendlist"
          format.js { render partial: "javascripts/groups/member_result" }
        end
      end
    else
      respond_to do |format|
        @group = current_user.groups.find(params[:group_id])
        @members = []
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: "javascripts/groups/member_result" }
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
