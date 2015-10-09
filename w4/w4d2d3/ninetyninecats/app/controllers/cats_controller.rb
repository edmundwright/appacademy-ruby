class CatsController < ApplicationController
  skip_before_action :redirect_to_cats

  before_action :check_editor_owns_cat
  skip_before_action :check_editor_owns_cat, except: [:edit, :update]


  def index
    @cats = Cat.all
    #render :index not necessary as method X automatically renders view X
  end

  def show
    @cat = Cat.find(params[:id])
    #render :show
  end

  def new
    @cat = Cat.new
    #render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    #render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to @cat # can use instead of cat_url(@cat)
    else
      render :edit
    end
  end

  def create
    options = cat_params.merge({user_id: current_user.id})
    @cat = Cat.new(options)
    @cat = current_user.cats.new(cat_params)

    if @cat.save
      redirect_to @cat
    else
      render :new
    end
  end

  private

  def check_editor_owns_cat
    cat = Cat.find(params[:id])
    if cat.owner != current_user
      flash[:notice] = "You unfortunately cannot edit someone elses cat. Sorry!"
      redirect_to cat_url(cat)

      # render text: "NOPE", status: :unauthorized
    end
  end

  def cat_params
    params.require(:cat).permit(:name,:color,:sex,:description,:birth_date)
  end


end
