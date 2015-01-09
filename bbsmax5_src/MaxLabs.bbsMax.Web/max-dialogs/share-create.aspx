<!--[DialogMaster title="��ӷ���/�ղ�" width="400"]-->
<!--[place id="body"]-->

<!--[if $isCanShare]-->

<!--[include src="_error_.ascx" /]-->
<!--[error name="subject"]-->
<div class="dialogmsg dialogmsg-error">$message</div>
<!--[/error]-->
<!--[error name="description"]-->
<div class="dialogmsg dialogmsg-error">$message</div>
<!--[/error]-->

<form action="$_form.action" method="post">
<div class="clearfix dialogbody">
    <div class="formgroup dialogform">
        <div class="formrow">
            <h3 class="label"><label for="description">����</label></h3>
            <div class="form-enter">
                <textarea id="description" name="description" cols="30" rows="2">$_form.text('description')</textarea>
            </div>
        </div>
        <div class="formrow">
            <h3 class="label">����Ԥ��</h3>
            <div class="form-enter">
                <div class="sharepreview">
                    <div class="sharepreview-title">
                        <input id="title" name="title" class="text" value="$_form.text('title','$Subject')" />
                    </div>
                    <div class="sharepreview-content">
                        <!--[if $ShareType == ShareType.Video]-->
                        <div class="videoplayer">
                            <!--[if $ImageUrl==null || $ImageUrl==""]-->
                            <img src="$Root/max-assets/images/default_media.gif" alt="" width="120" height="90" />
                            <!--[else]-->
                            <img src="$ImageUrl" alt="" width="120" height="90" />
                            <!--[/if]-->
                        </div>
                        <!--[else if $ShareType == ShareType.Music]-->
                        <div class="audioplayer">
                            <object id="audioplayer_1" height="24" width="290" data="/max-assets/flash/player.swf" type="application/x-shockwave-flash">
                                <param value="/max-assets/flash/player.swf" name="movie" />
                                <param value="autostart=no&bg=0xEBF3F8&leftbg=0x6B9FCE&lefticon=0xFFFFFF&rightbg=0x6B9FCE&rightbghover=0x357DCE&righticon=0xFFFFFF&righticonhover=0xFFFFFF&text=0x357DCE&slider=0x357DCE&track=0xFFFFFF&border=0xFFFFFF&loader=0xAF2910&soundFile=$Content" name="FlashVars" />
                                <param value="high" name="quality" />
                                <param value="false" name="menu" />
                                <param value="#ffffff" name="bgcolor" />
                            </object>
                        </div>
                        <!--[else if $ShareType == ShareType.URL]-->
                        <a href="$Content" target="_blank">$Content</a>
                        <!--[else]-->
                        $Content
                        <!--[/if]-->
                    </div>
                    <input type="hidden" name="securityCode" value="$_form.text("securityCode",$GetShareContentSafeSerial($content,$userID))" />
                    <input type="hidden" name="urlSecurityCode" value="$_form.text("urlSecurityCode",$GetShareContentSafeSerial($url,$userID))" />
                    <input type="hidden" name="content" value="$hidecontent" />
                    <input type="hidden" name="url" value="$hideurl" />
                    <input type="hidden" name="userid" value="$_form.text("userid",$userID)" />
                    <input type="hidden" name="shareType" value="$shareType" />
                    <input type="hidden" name="refshareid" value="$refshareid" />
                </div>
            </div>
        </div>
        <!--[ValidateCode actionType="createshare"]-->
        <div class="formrow">
            <h3 class="label"><label for="$inputName">��֤��</label></h3>
            <div class="form-enter">
                <input type="text" class="text validcode" name="$inputName" id="$inputName" $_if($disableIme,'style="ime-mode:disabled;"') autocomplete="off" />
                <span class="captcha">
                    <img src="$imageurl" onclick="this.src='$imageurl?r='+(new Date().getMilliseconds())" alt="" />
                </span>
                <!--[error name="$inputName"]-->
                <span class="form-tip tip-error">$message</span>
                <!--[/error]-->
            </div>
            <div class="form-note">$tip</div>
        </div>
        <!--[/ValidateCode]-->
    </div>
</div>
<div class="clearfix dialogfoot">
    <!--[if $IsCollection == false]-->
    <button class="button button-highlight" type="submit" name="shareforeveryone" title="�����������"><span>�����������</span></button>
    <button class="button button-highlight" type="submit" name="shareforfriend" title="���������"><span>���������</span></button>
    <!--[else]-->
    <button class="button button-highlight" type="submit" name="shareforselfe" title="�ղ�"><span>�ղ�</span></button>
    <!--[/if]-->
    <button class="button" type="reset" accesskey="c" title="ȡ��" onclick="panel.close();"><span>ȡ��(<u>C</u>)</span></button>
</div>
</form>
<!--[else]-->
<div class="clearfix dialogbody">
    <div class="dialogconfirm">
        <h3>��Ϊ��˽���ò��ܹ���������ղ�.</h3>
    </div>
</div>
<div class="clearfix dialogfoot">
    <button class="button" type="button" accesskey="c" title="ȡ��"><span>ȡ��(<u>C</u>)</span></button>
</div>
<!--[/if]-->
<script type="text/javascript">
    currentPanel.result = "close";
</script>
<!--[/place]-->
<!--[/DialogMaster]-->
