<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><!--[if $isEdit]-->�༭ͼ��<!--[else]-->���ͼ��<!--[/if]--></title>
<!--[include src="../_htmlhead_.aspx"/]-->
</head>
<body>
<!--[include src="../_head_.aspx"/]-->
<!--[include src="../_setting_msg_.aspx"/]-->

<form action="$_form.action" method="post">
<div class="Content">
    <div class="PageHeading">
	<h3><!--[if $isEdit]-->�༭ͼ��<!--[else]-->���ͼ��<!--[/if]--></h3>
	<div class="ActionsBar">
	    <a class="back" href="$admin/interactive/setting-medals.aspx"><span>����ͼ������б�</span></a>
	</div>
	</div>
	<div class="FormTable">
	<table>
        <!--[error name="medalname"]-->
            <!--[include src="../_error_.aspx" /]-->
        <!--[/error]-->
		<tr>
			<th>
			    <h4>ͼ������</h4>
			    <input name="medalname" id="medalname" type="text" class="text" value="$_form.text('medalname',$out($Medal.Name))" />
			</th>
			<td>ͼ������</td>
		</tr>
        <!--[error name="sortorder"]-->
            <!--[include src="../_error_.aspx" /]-->
        <!--[/error]-->
		<tr>
			<th>
			    <h4>����</h4>
			    <input name="sortorder" id="sortorder" type="text" class="text number" value="$_form.text('sortorder',$out($Medal.SortOrder))" />
			</th>
			<td>��д���֣�����ԽСѫ������Խǰ��</td>
		</tr>
		<tr>
			<th>
			    <h4>����</h4>
                <!--[if $isEdit]-->
                <input name="enable" id="enable" type="checkbox" value="true" $_form.checked('enable','true',$out($Medal.Enable)) />
                <!--[else]-->
                <input name="enable" id="enable" type="checkbox" value="true" $_form.checked('enable','true',true) />
                <!--[/if]-->
                <label for="enable">�Ƿ����ø�ͼ��</label>
			</th>
			<td></td>
		</tr>
		<tr>
			<th>
			    <h4>δ����ʱ����</h4>
                <input name="isHidden" id="isHidden" type="checkbox" value="true" $_form.checked('isHidden','true',$out($Medal.IsHidden)) />
                <label for="isHidden">δ����ʱ����</label>
			</th>
			<td>����û���ͼ��δ�����������ˣ��û����ῴ����ͼ�꣬�����ѵ�����ͼ����Ч</td>
		</tr>
        <!--[if $isEdit]-->
        <tr>
            <th>
                <h4>�Զ�����ͼ��</h4>
                <input type="checkbox" name="isauto" id="isauto" value="true" onclick="setConditionType(this.checked)" $_form.checked('isauto','true',{=$Medal.IsCustom == false}) />
                <label for="isauto">�Ƿ��Զ�����ͼ��</label>
            </th>
            <td>&nbsp;</td>
        </tr>
        <!--[else]-->
        <tr>
            <th>
                <h4>�Զ�����ͼ��</h4>
                <input type="checkbox" name="isauto" id="isauto" value="true" onclick="setConditionType(this.checked)" $_form.checked('isauto','true',true) />
                <label for="isauto">�Ƿ��Զ�����ͼ��</label>
            </th>
            <td>�Զ�����ͼ����ָ���û��������ﵽ���������ֵʱϵͳ�Զ����û�����ͼ�꣬������Զ���������Ҫ����Ա�ֶ�����ͼ��;
            </td>
        </tr>
        <!--[/if]-->
        <!--[error name="medallevel"]-->
            <!--[include src="../_error_.aspx" /]-->
        <!--[/error]-->
		<tr>
			<th>
			    <div class="itemtitle">
			        <strong>ͼ��ȼ�</strong>
			        <a class="addexceptrule" href="#" name="addlevel" onclick="add();return false;">���ͼ��ȼ�</a>
                    <input type="hidden" name="ids" id="ids" value="" />
                    <input type="hidden" name="maxid" id="maxid" value="0" />
                    <input type="hidden" name="condition" id="condition" value="" />
                </div>
                <div class="exceptrule">
                <table id="" style="display:none">
                        <tr id="level_list_item">
                            <td id="level_content">
                                <p>
                                �ȼ�����:
                                <input name="levelName_{id}" type="text" class="text" style="width:10em;" value="{levelName}" />
                                </p>
                                <p id="condition_auto_{id}">
                                    ����ͼ�����:
                                    <select name="condition_{id}" id="condition_{id}" onchange="selectAllCondition(this.value)">
                                    <option value="">��ѡ�����</option>
                                    <option value="Point_0">�ܻ���</option>
                                    <!--[loop $Colum in $Colums]-->
                                    <option value="$Colum.Colum">$Colum.Description</option>
                                    <!--[/loop]-->
                                    </select>
                                    �ﵽ:
                                    <input type="text" name="levelValue_{id}" class="text"  style="width:5em" value="{levelValue}" />
                                </p>
                                <p id="condition_custom_{id}">
                                    ����ͼ������:
                                    <input type="text" name="conditionDescription_{id}" class="text" style="width:15em;" value="{conditionDescription}" />
                                </p>
                                <p>
                                    ͼ��:
                                    <input name="iconSrc_{id}" type="text" class="text" id="iconSrc_{id}" style="width:9em;" value="{iconSrc}" />
	                                <a title="ѡ��ͼƬ" class="selector-image" href="javascript:void(browseImage('Assets_MedalIcon','iconSrc_{id}'))"><img src="$Root/max-assets/images/image.gif" alt="" /></a>
                                </p>
                            </td>
                            <td id="level_action">
                                <a href="#" name="delete" onclick="deleteLevel('{id}');return false;">ɾ��</a>
                            </td>
                        </tr>
                </table>
                <table id="level_list">
                </table>
                </div>
			</th>
			<td>&nbsp;</td>
		</tr>
		<tr class="nohover">
		    <th>
		        <input type="submit" name="savesetting" value="��������" class="button" />
		    </th>
		    <td>&nbsp;</td>
	    </tr>
	</table>
    </div>
</div>
</form>
<script type="text/javascript">

var level_list = $('level_list');
var level_content = fix($('level_content').innerHTML);
var level_action = fix($('level_action').innerHTML);
//var level_list_item = fix($('level_list_item').innerHTML);
//level_list.outerHTML = '';

var isAuto = true;
//<!--[if $IsCustom]-->
    isAuto = false;
//<!--[/if]-->
//<!--[loop $MedalLevel in $MedalLevels]-->
    addLevel($MedalLevel.ID,'$MedalLevel.Name','$MedalCondition','$MedalLevel.Value','$MedalLevel.Condition','$MedalLevel.IconSrc',isAuto);
//<!--[/loop]-->
init();
function init()
{
    if($('ids').value!='')
    {
    }
    else
        add();
}
function add()
{
    var maxid = parseInt($('maxid').value);
    addLevel(maxid+1,'',$('condition').value,'','','',true);
}



function addLevel(id,levelName,condition,levelValue,conditionDescription,iconSrc,isauto)
{
    var maxid = parseInt($('maxid').value);
    if(id>maxid)
        $('maxid').value = id;
        
    $('ids').value = ($('ids').value+ ',' + id).trimStart(',');
    var contentString = level_content.replace(/\{id\}/g, id).replace(/\{levelName\}/g, levelName).replace(/\{condition\}/g, condition).replace(/\{levelValue\}/g, levelValue).replace(/\{conditionDescription\}/g, conditionDescription).replace(/\{iconSrc\}/g, iconSrc);
    var actionString = level_action.replace(/\{id\}/g, id).replace(/\{levelName\}/g, levelName).replace(/\{condition\}/g, condition).replace(/\{levelValue\}/g, levelValue).replace(/\{conditionDescription\}/g, conditionDescription).replace(/\{iconSrc\}/g, iconSrc);
    
    var row = level_list.insertRow(level_list.rows.length);
    row.id = 'level_list_item_' + id;
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    cell1.innerHTML = contentString;
    cell2.innerHTML = actionString;
    
    $('condition').value = condition;
    selectCondition(id,condition);
    setItemConditionType($('isauto').checked,id);
}
function deleteLevel(id)
{
    $('ids').value = (',' + $('ids').value + ',').replace(',' + id + ',', ',').trimStart(',').trimEnd(',');
    removeElement($('level_list_item_' + id));
}

var isSetCondition = false;
function selectAllCondition(value)
{
    if(isSetCondition)
        return;
       
    isSetCondition = true;
    $('condition').value = value;
    var ids =  $('ids').value.trimStart(',').trimEnd(',').split(',');
    for(var i = 0;i < ids.length; i++)
    {
        selectCondition(ids[i],value);
    }
    
    isSetCondition = false;
}
function selectCondition(id,value)
{
    var obj = $('condition_'+id);
    for(var i=0; i<obj.options.length; i++)
    {
         if(obj.options[i].value==value)
         {
            obj.options[i].selected = true;
            break;
         }
    }
}
function setConditionType(isauto)
{
    var ids =  $('ids').value.trimStart(',').trimEnd(',').split(',');
    for(var i = 0;i < ids.length; i++)
    {
        setItemConditionType(isauto,ids[i]);
    }
}
function setItemConditionType(isauto,id)
{
    if(isauto)
    {
        $('condition_auto_'+id).style.display = '';
        $('condition_custom_'+id).style.display = 'none';
    }
    else
    {
        $('condition_auto_'+id).style.display = 'none';
        $('condition_custom_'+id).style.display = '';
    }
}
function fix(str) {
        return str.replace(/value=\{([\w]+)\}/g, 'value="{$1}"');
    };
</script>
<!--[include src="../_foot_.aspx"/]-->
</body>
</html>