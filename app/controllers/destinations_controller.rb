class DestinationsController < ApplicationController


    def index
        if params[:goal_id]
            @goal =Goal.find_by(id:params[:goal_id])
            #byebug
            @destinations = @goal.destinations
        else
            #@destinations = Destination.all
            redirect_to '/goals'
        end 
    end 

    def new
        if params[:goal_id]
            @goal = Goal.find_or_create_by(id:params[:goal_id])
            @destination = @goal.destinations.build
        else
            @destination = Destination.new
        end
    end 
    
    def create
        @goal = Goal.find_by(id:params[:goal_id])
        @traveler = current_traveler
        @destination = @traveler.destinations.build(destination_params)
            if @destination.save
                redirect_to goal_destinations_path(@goal)
            else
                redirect_to goals_path, notice: 'Destination was not added!'
            end
    end 

    def show
        @destination = Destination.find_by(id:params[:id])
        if params[:id]
            @goal = Goal.find_by(id:params[:goal_id])
            if @destination.goal_id != @goal.id
                redirect_to goal_destinations_path
            end
        end 

    end 

    # def edit
    # end

    # def update
    # end 

    # def destroy
    # end

    private
    def destination_params
        params.require(:destination).permit(:location, :description, :date_traveled, :completed, :traveler_id, :goal_id)
    end 

end
