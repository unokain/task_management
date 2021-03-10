
    class UsersController < ApplicationController
        skip_before_action :login_required, only: [:new, :create]
        before_action :set_current_user
        before_action :ensure_current_user, {only: [:show]}
        before_action :not_ensure_current_user, {only: [:new]}   
        def new
            @user = User.new #newページを生成
        end
        def create
            @user = User.new(user_params)
            if @user.save
              session[:user_id] = @user.id
              redirect_to user_path(@user.id)
            else
              render :new
            end
        end
        def show
            @user = User.find(params[:id])
        end
        private
        def user_params
            params.require(:user).permit(:name,:email,:password,
                                         :password_confirmation)#permitで指定しているシンボルのパラメータのみデータ送信を許可
        end
        def ensure_current_user
            if @current_user.id != params[:id].to_i
                flash[:notice]="権限がありません"
                redirect_to tasks_path
            end
        end
        def not_ensure_current_user
            if @current_user
                flash[:notice]="ログインしています"
                redirect_to tasks_path
            end
        end
    end

