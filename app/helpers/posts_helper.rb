module PostsHelper

  def display_likes(post)
    votes = post.votes_for.up.by_type("User")
    return list_likers(votes) if votes.size <= 8
    count_likers(votes)
  end
  # Our new helper method


  def liked_post(post)
    if current_user.voted_for? post
      return [unlike_post_path(post.id),'glyphicon-heart']
    else
      return [like_post_path(post.id),'glyphicon-heart-empty']
    end
  end
  private

  def list_likers(votes)
    pseudos = []
    unless votes.blank?
      votes.voters.each do |voter|
        pseudos.push(link_to voter.pseudo, profiles_path(voter.id.to_s + "_" + voter.first_name + "-" + voter.last_name), class: 'user-name')
      end
      pseudos.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
