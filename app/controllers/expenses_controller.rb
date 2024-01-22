# expense controller
class ExpensesController < ApplicationController
  before_action :set_expense_group_and_expense, only: [:index, :new, :create, :edit, :show, :update, :destroy]

  def index
    @expenses = @expense_group.expenses
  end

  def new
    @expense = @expense_group.expenses.build
  end

  def create
    @expense = @expense_group.expenses.build(expense_params)

    if @expense.save
      flash[:notice] = "Expense added successfully."
      redirect_to expense_group_path(@expense_group)
    else
      render 'new'
    end
  end

  def destroy
    @expense.destroy
    flash[:notice] = "Expense deleted successfully."
    redirect_to expense_group_path(@expense_group)
  end

  private

  def set_expense_group_and_expense
    @expense_group = ExpenseGroup.find(params[:expense_group_id])
    @expense = @expense_group.expenses.find(params[:id]) if params[:id]
  end

  def expense_params
    params.require(:expense).permit(:description, :amount, :user_id)
  end
end
