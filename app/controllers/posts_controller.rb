class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_action :authenticate_user!, except: [:index, :show]

  skip_before_action :verify_authenticity_token
  # GET /posts
  # GET /posts.json
  def result
    @post = Post.find(params[:post_id])
    @questions = @post.questions
    @answers = @post.answers
    @ans_num = @answers.count
    
  end
  def questioncreate
    question = Question.new
    question.post_id = params[:post_id]
    question.content = params[:content]
    question.q_type = params[:q_type]
    question.save
    redirect_to action: "show", id: params[:post_id]
  end
  def questiondestroy
    question = Question.find(params[:question_id])
    question.destroy
    redirect_to action: "show", id: params[:post_id]
  end
  def questionedit
    @question = Question.find(params[:question_id])
    @post = Post.find(params[:post_id])
    @q_num = @post.questions.index(@question)+1
  end
  def questionupdate
    post = Post.find(params[:post_id])
    question = Question.find(params[:question_id])
    question.content = params[:content]
    question.q_type = params[:q_type]
    question.save
    redirect_to action: "show", id: params[:post_id]
  end
  def selectioncreate
    selection = Selection.new
    selection.question_id = params[:question_id]
    selection.content = params[:selection_content]
    selection.num = 0
    selection.save
    redirect_to action: "show", id: params[:post_id]
  end
  def selectiondestroy
    selection = Selection.find(params[:selection_id])
    selection.destroy
    redirect_back fallback_location: root_path
  end
  def answernew
    @answer = Answer.new
    @post = Post.find(params[:post_id_for_you])
    @questions = @post.questions
    @q_num = @post.questions.count
  end

  def answercreate
    
    answer = Answer.new
    answer.post_id = params[:post_id_for_you] 
    answer.content = params[:content]
    answer.ans_email = params[:email]
    answer.save

    @post = Post.find(params[:post_id_for_you])
    q_num = @post.questions.count
    @questions = @post.questions
    q_num.times do |x| #x=0,1,2,.... questions의 index를 이용한다. 
      item = Item.new
      question = @questions[x]
      if question.q_type=="text"
        item.content = params[('item_'+x.to_s+'_text').to_sym]
      elsif question.q_type=="radio"
        item.content = params[('item_'+x.to_s+'_radio').to_sym]
        qselec = question.selections.where(:content => item.content)[0]
        qselec.num+=1
        qselec.save
      elsif question.q_type=="checkbox"
        item.content = ""
        question.selections.count.times do |y|
          selec = params[('item_'+x.to_s+'_checkbox_'+y.to_s).to_sym]
          unless selec==nil
            item.content+=selec
            item.content+=", "
            qselec = question.selections.where(:content => selec)[0]
            qselec.num+=1
            qselec.save
          end
        end
      end
      item.post_id = params[:post_id_for_you] #integer가 두개(primary key가 헷갈림)여서 그런지 값이 안들어감. 어차피
      item.item_email = params[:email]         #필요없음. a가 item이라면 a.answer.post.id 쓰면 됨
      item.answer_id = answer.id  #primary key in many_items_belong_to_answer association
      item.save
    end

    @results = answer.items.all
    @i_num = 0
  end

  

  def index
    @posts = Post.all
    @ability = Ability.new(current_user)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @ability = Ability.new(current_user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @q= "%#{params[:query]}%"
    @projects=Post.where("title LIKE ? or content LIKE ?", @q, @q)
    render 'posts/search'
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :email)
    end



end
