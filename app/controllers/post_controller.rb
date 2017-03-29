class PostController < ApplicationController
  def new
    if contributor_logged_in?
      @post = Post.new
    end
  end

  def create
    if contributor_logged_in?
      @post = Post.new(post_params)
      @post.contributor = current_contributor
      if @post.save
        flash.now[:success] = 'New post created.'
        render 'new'
      else
        flash.now[:danger] = @post.errors.full_messages.join("<br>").html_safe
        render 'new'
      end
    end
  end

  def edit
    if contributor_logged_in?
      post = Post.find(params[:post_id])
      if current_contributor.id == post.contributor_id
        @post = post
      end
    end
  end

  def update
    if contributor_logged_in?
      post = Post.find(params[:post_id])
      if current_contributor.id == post.contributor_id
        if post.update_attributes(post_params)
          flash.now[:success] = 'Post updated.'
          render 'edit'
        else
          flash.now[:danger] = @post.errors.full_messages.join("<br>").html_safe
          render 'edit'
        end
      end
    end
  end

  def show
    @post = Post.find(params[:post_id])
  end

  def delete
    if contributor_logged_in?
      post = Post.find(params[:post_id])
      if post.contributor_id == current_contributor.id
        post.delete
        redirect_to posts_path
      end
    end
    if admin_logged_in?
      post = Post.find(params[:post_id])
      post.delete
      redirect_to posts_path
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :bootsy_image_gallery_id)
    end
end
