class IssuesController < ApplicationController


private
  def issue_params
    params.require(:issue).permit(:number, :cover, :title_id)
  end
end
