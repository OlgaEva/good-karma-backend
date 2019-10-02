class MessagesController < ApplicationController

    before_action :find_message, only: [:show, :update, :destroy]
    
    def index
        @messages = Message.all
        render json: @messages, include: [:messagee, :messenger]
    end

    def show
        render json: @message
    end

    def create
        @message = Message.create(message_params)
        render json: @message
    end

    def update
        @message.update(message_params)
    end

    def destroy 
        @message.destroy
    end

    private

    def message_params
        params.require(:message).permit(:messenger_id, :messagee_id, :message, :job_id)
    end

    def find_message
        @message = Message.find(params[:id])
    end

end

