class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy toggle_status]


    # GET /stories or /stories.json
    def index
      @users = User.all
      @page_title="Users"
      authorize @users 
      # if current_user.has_role? :admin
      #   @users = User.all
      #   @page_title="Users"
      # else
      #   redirect_to root_path, alert: 'Not Authorized'
      # end
    end

    def edit 
      authorize @user
    end

    def update
      authorize @user 
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to users_url, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private 
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user=User.find(params[:id ])
    end

    def user_params
      params.require(:user).permit(role_ids: [])
    end
  
  end
  