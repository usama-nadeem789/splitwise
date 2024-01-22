# friendship controller
class FriendshipsController < ApplicationController

  def index
    @user = current_user
    @friendship = @user.friends
  end

  def new
    @friendship = Friendship.new
  end

  def create
    email = params[:friendship][:email]
    friend = User.find_by(email: email)
  
    if friend
      if current_user == friend
        flash[:alert] = "You cannot add yourself as a friend."

      elsif current_user.friends.include?(friend)
        flash[:alert] = "Already your friend."
      else
        Friendship.create(user: current_user, friend: friend)
        Friendship.create(user: friend, friend: current_user)
        flash[:notice] = "Friend added"
      end
    else
      flash[:alert] = "User not found."
    end
  
    redirect_to friendships_path
  end

  def destroy
    friend_id = params[:id]
    friendship = Friendship.find_by(friend_id: friend_id, user_id: current_user.id)
    reverse_friendship = Friendship.find_by(friend_id: current_user.id, user_id: friend_id)

    if friendship
      friendship.destroy
      reverse_friendship.destroy
      flash[:notice] = "Friendship destroyed"

    else
      flash[:alert] = "Friendship not found"
    end

    redirect_to friendships_path
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:email)
  end

end