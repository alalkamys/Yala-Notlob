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
    puts "params: #{params}"
    puts "params[:user] #{params[:user]}"
    puts "@member: #{@member}"
    # @member = current_user.groups.find(params[:group_id]).group_member.new(user_id: @member.id)
    @member = GroupsUser.new({"user_id"=> @member.id ,"group_id"=> params[:group_id ] })
    @member.save
    redirect_to group_add_user_path
  end

  def destroy_user
    GroupsUser.delete_by(user_id: params[:user_id] ,group_id: params[:group_id])
    # Group.find(params[:group_id]).memberships.where(member_id: params[:member_id])[0].destroy
    # GroupsUser.where(member_id: params[:member_id])[0].destroy
   
    redirect_to group_add_user_path
  end

  #TODO needs a lot of working
  def search
    if params[:email].present?
      @group = current_user.groups.find(params[:group_id])
      # @members = User.find_by email: params[:user]
      @members = User.where(email: params[:email])
      # @members = current_user.except_current_user(@members)
      if @members
        respond_to do |format|
          format.js { render partial: "groups/member_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: "groups/member_result" }
        end
      end
    else
      respond_to do |format|
        @group = current_user.groups.find(params[:group_id])
        @members = []
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: "groups/member_result" }
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
