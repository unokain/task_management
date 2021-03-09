class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      if params[:keyword].present? && params[:stage].present?
        @tasks = Task.page(params[:page]).per(8).search_composite(params[:keyword],params[:stage]).limit(20)
      elsif params[:keyword].present?
        @tasks = Task.page(params[:page]).per(8).search_task_name(params[:keyword]).limit(20)
      elsif params[:stage].present?
        @tasks = Task.page(params[:page]).per(8).search_status(params[:stage]).limit(20)
      elsif params[:sort_expired].present?
        @tasks = Task.page(params[:page]).per(8).limit_sort
      elsif params[:sort_pro].present?
        @tasks = Task.page(params[:page]).per(8).priority_sort
      elsif
        @tasks = Task.page(params[:page]).per(8).order(created_at: :desc)
      end
    end
    def new
      if params[:back]
        @task = Task.new(task_params)
      else
        @task = Task.new
      end
    end
    def create
      @task = Task.new (task_params)
      #@task.user_id = current_user.id
      if params[:back]
        render :new
      else
        if @task.save
          redirect_to task_path(@task.id), notice:"タスクを投稿しました"
        else
          render :new
        end
      end
    end
    def show
      @task = Task.find(params[:id])
    end
    def edit
      @task = Task.find(params[:id])
    end
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to tasks_path, notice:"タスクを更新しました"
      else
        render :edit
      end
    end
    def destroy
      @task.destroy
      redirect_to tasks_path, notice:"タスクを削除しました！"
    end
    # def confirm
    #   @task = current_user.tasks.build(task_params)
    #   render :new if @picture.invalid?
    # end
    private
    def task_params
      params.require(:task).permit(:task_name, :details, :limit, :status, :priority)
    end
    def set_task
     @task = Task.find(params[:id])
    end
end
