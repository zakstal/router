class ContactsController < ApplicationController
  def index

    user = User.find(params[:user_id])
    shared = user.shared_contacts
    contacts = user.contacts

    render json: {user_contacts: contacts, shared_contacts: shared}
  end

  def create
    contact = Contact.new(param_stuff)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    contact = Contact.find(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find(params[:id])
    contact.update(param_stuff)
    render json: contact
  end

  def destroy
    contact = Contact.destroy(param_stuff[:id])
    render json: contact
  end

  private
  def param_stuff
    params.permit(:name, :user_id, :email)
  end

end
