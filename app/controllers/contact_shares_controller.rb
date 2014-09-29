class ContactSharesController < ApplicationController
  def create
    share = ContactShare.new(param_stuff)
    if share.save
      render json: share
    else
      render(
        json: share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    share = ContactShare.destroy(param_stuff[:id])
    render json: share
  end

  private
  def param_stuff
    params.require(:contact_share).permit(:user_id, :contact_id)
  end
end
