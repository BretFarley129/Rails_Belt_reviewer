class EventsController < ApplicationController
  def index
    @date = Date.today
    @user = current_user
    @local_events = Event.where(state: @user.state)
    @other_events = Event.where.not(state: @user.state)
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.valid?
      flash[:errors] = ['Success']
      @event.save
      redirect_to :back
    else
      flash[:errors] = @event.errors
      redirect_to :back
    end
  end

  def join
    @event = Event.find(params[:id])
    @user = current_user
    attend = Attendee.new(event: @event, user: @user)
    if attend.valid?
      attend.save
      redirect_to :back
    else
      flash[:errors] = ['Something went wrong']
      redirect_to :back
    end
  end

  def comment
    @event = Event.find(params[:id])
    @user = current_user
    comment = Comment.new(event: @event, user: @user)
    comment.content = params['content']
    if comment.valid?
      comment.save
      redirect_to :back
    else
      flash[:errors] = ['Something went wrong']
      redirect_to :back
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @user = current_user
    attend = Attendee.find_by(event: @event, user: @user)
    if attend.valid?
      attend.destroy
      redirect_to :back
    else
      flash[:errors] = ['Something went wrong']
      redirect_to :back
    end
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to '/events'
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :city, :state)
  end
end
