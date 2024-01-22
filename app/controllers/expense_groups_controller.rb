# expense group controller
class ExpenseGroupsController < ApplicationController
  before_action :set_expense_group, only: [:show, :destroy, :add_friends, :remove_friend, :create_membership]

  def index
    @expense_groups = current_user.expense_group
  end

  def new
    @expense_group = ExpenseGroup.new
  end

  def create
    @expense_group = ExpenseGroup.new(expense_group_params)
    @expense_group.created_by = current_user.email

    if @expense_group.save
      @expense_group.users << current_user
      flash[:notice] = "Expense group created successfully."
      redirect_to expense_groups_path
    else
      render 'new'
    end
  end

  def destroy
    if @expense_group.destroy
      flash[:notice] = "Expense group deleted successfully."
    else
      flash[:alert] = "Failed to delete the expense group."
    end

    redirect_to expense_groups_path
  end

  def show
    @expenses = @expense_group.expenses
    @user_balances = calculate_user_balances(@expense_group)
  end

  def calculate_user_balances(expense_group)
    total_amount_paid = Expense.where(expense_group:).sum(:amount)
    total_users = @expense_group.users.count
    equal_share = total_amount_paid / total_users

    user_balances = {}

    @expense_group.users.each do |user|
      user_expenses = Expense.where(expense_group:, user:).sum(:amount)
      user_balance = (equal_share - user_expenses).round(2)
      user_balances[user] = user_balance
    end

    user_balances[:total_amount_paid] = total_amount_paid
    user_balances[:equal_share] = equal_share.round(2)

    user_balances
  end

  def add_friends
    @friends = current_user.friends
  end

  def create_membership
    @user = User.find(params[:user_id])

    if @expense_group.users.include?(@user)
      flash[:alert] = "User is already in the group."
    else
      @expense_group.users << @user
      flash[:notice] = "User added to the group."
    end

    redirect_to expense_group_path(@expense_group)
  end

  def remove_friend
    @user = User.find(params[:user_id])

    if @expense_group.users.include?(@user)
      @expense_group.users.delete(@user)
      flash[:notice] = "User removed from the group."
    else
      flash[:alert] = "User is not in the group."
    end

    redirect_to expense_group_path(@expense_group)
  end

  private

  def set_expense_group
    @expense_group = ExpenseGroup.find(params[:id])
  end

  def expense_group_params
    params.require(:expense_group).permit(:name)
  end
end
