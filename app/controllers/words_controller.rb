class WordsController < ApplicationController
  before_filter :confirmSession
  
  # GET /words
  # GET /words.json
  def index

      
    if params[:target_category] != nil
      @words = Word.joins("LEFT OUTER JOIN categories ON words.category_id = categories.id")
      .where(:user_id => session[:userid]).where(:category_id => params[:target_category])
      .select("words.id, type_name, problem, answer")
    else
      @words = Word.joins("LEFT OUTER JOIN categories ON words.category_id = categories.id")
      .where(:user_id => session[:userid])
      .select("words.id, type_name, problem, answer")
    end

    @category = Category.find_all_by_user_id(session[:userid])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new
    @category = Category.find_all_by_user_id(session[:userid])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/1/edit_
  def edit
    @word = Word.find(params[:id])
    @category = Category.find_all_by_user_id(session[:userid])
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])
    @word.user_id = session[:userid];
    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :ok }
    end
  end
end
