class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
      @tasks = Task.all 
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
          redirect_to tasks_path, notice:"タスクを投稿しました"
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
      params.require(:task).permit(:task_name, :details)
    end
    def set_task
     @task = Task.find(params[:id])
    end
end
