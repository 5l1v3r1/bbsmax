<!--[if $post.PostMarks.Count!=0]-->
<div class="post-score">
    <h3 class="post-score-title">
        <span>�������� <span class="count">��$post.MarkCount��</span></span>
        <span class="post-score-link">
            <a class="post-score-action" href="$Dialog/post-rate.aspx?postid=$post.postid&postAlias=$UrlEncode($post.PostIndexAlias)" onclick="return openDialog(this.href, null)">��Ҫ����</a>
        </span>
    </h3>
    <div class="clearfix post-score-content">
        <ul class="post-score-list">
            <!--[loop $postMark in $post.PostMarks]-->
            <li class="clearfix">
                <a class="fn" href="$url(space/$postMark.UserID)" target="_blank">$postMark.Username</a>:
                <span class="post-score-score">$postMark.GetPostMarkPoints(@"<span class=""label"">{0}:</span> <span class=""value"">+{1}</span> ",@"<span class=""label"">{0}:</span> <span class=""value negative"">{1}</span> ")</span>
                <span class="post-score-reason">$postMark.Reason</span>
                <span class="date">$outputFriendlyDateTime($postMark.CreateDate)</span>
            </li>
            <!--[/loop]-->
        </ul>
        <!--[if $post.MarkCount > $post.PostMarks.Count]-->
        <div class="post-score-count">
            ��ǰ��ʾ���$post.PostMarks.Count��
            <a class="post-score-loglink" href="$Dialog/post-rateusers.aspx?postid=$post.postid" onclick="return openDialog(this.href, null)">�鿴���ּ�¼</a>
        </div>
        <!--[/if]-->
    </div>
</div>
 <!--[/if]-->
