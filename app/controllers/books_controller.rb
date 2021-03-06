class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    @books = Book.paginate(:page => params[:page], :per_page => 10, :order => 'created_at DESC')  

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :ok }
    end
  end

  def new_from_isbn
    @book = Book.new
   
    respond_to do |format|
      format.html      
      format.json { render json: @book }
    end
  end

  def new_from_plural_isbn
    @book = Book.new

    respond_to do |format|
      format.html
      format.json { render json: @book }
    end
  end

  def create_from_isbn 
    @book = Book.create({:isbn13 => params[:isbn]})

    respond_to do |format|
      unless @book.id == nil
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new_from_isbn" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_from_plural_isbn
    @book = Book.new
    count_before = Book.count
    isbns = []
    created_books_id = []
    flag = true
    params[:plural_isbn].each_line do |isbn|
      isbn.chomp!
      isbns << {:isbn13 => isbn} unless  isbn == ""
    end

    if isbns.size == 0
      @book.errors.add(:isbn, "is not inputted")
      flag = false
    end
 
    begin
      Book.transaction do
        isbns.each do |isbn|
          book = Book.create(isbn)
          if book.id == nil
            raise ActiveRecord::RecordInvalid.new(book)
          end
        end
      end

    rescue
      flag = false
      @book.errors.add(:isbn, "is not currect")
    end

    respond_to do |format|
      if flag
        format.html { redirect_to books_url, notice: "#{Book.count - count_before} books was registered." }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new_from_plural_isbn" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

=begin  
  def rent
    @book = Book.find(params[:id])
    if @book.status == 1
      @book.errors.add(:isbn, "is rented")
    else
      @book.status = 1
      history = History.new(:book_id => @book.id, :user_id => User.current, :action => 1)
      history.save
    end
    respond_to do |format|
      if @book.save
        format.html { redirect_to books_url, notice: 'Book was successfully changed.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
=end

  def return
    @book = Book.find(params[:book_id])
    subscription_request = SubscriptionRequest.find(params[:subscription_request_id])
    subscription_request.return_date = Date.today
    if @book.status == 0
      @book.errors.add(:isbn, "is returned")
    else
      @book.status = 0
      history = History.new(:book_id => params[:book_id], :user_id => User.current.id, :action => 0)
      history.save
    end
    
    respond_to do |format|
      if @book.save && subscription_request.save
        format.html { redirect_to books_url, notice: 'Book was successfully changed.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def list_subscription_requests
    @book = Book.find(params[:book])
    @subscription_requests = SubscriptionRequest.where(:book_id => @book.id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subscription_requests }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :publisher, :isbn13, :price, :page, :width, :height, :depth, :status, :created_at, :updated_at)
    end
end
