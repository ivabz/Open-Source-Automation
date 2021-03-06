﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="screens.aspx.cs" Inherits="screens" %>
<%@ MasterType virtualpath="~/MasterPage.master" %>

<%@ Reference Control="~/controls/ctrlStateImage.ascx"  %>
<%@ Reference Control="~/controls/ctrlPropertyLabel.ascx"  %>
<%@ Reference Control="~/controls/ctrlTimerLabel.ascx"  %>
<%@ Reference Control="~/controls/ctrlMethodImage.ascx"  %>
<%@ Reference Control="~/controls/ctrlNavigationImage.ascx"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
    <style type="text/css">
        
        .screen-bg {
            max-width: none;
            border-width:0px;
            position:absolute;
            top:50px;
            left:10px;
            z-index:0;
        }
    </style>
    <script type="text/javascript">
        var host = '';

        $(document).ready(function () {
            host = window.location.hostname;
            startRefresh();
        });


        function startRefresh() {
            setTimeout(startRefresh, 5000);
            $('#<%=UpdateButton.ClientID %>').click();
        }

        function runMethod(object, method, p1, p2) {
            if (p1 != '') {
                $.post('http://' + host + ':8732/api/object/' + object + '/' + method + '?param1=' + p1 + '&callback=?', null, function (data) {
                    return data;
                });
            }
            else if (p2 != '') {
                $.post('http://' + host + ':8732/api/object/' + object + '/' + method + '?param1=' + p1 + '&param2=' + p2 + '&callback=?', null, function (data) {
                    return data;
                });
            }
            else {
                $.post('http://' + host + ':8732/api/object/' + object + '/' + method + '?callback=?', null, function (data) {
                    return data;
                });
            }

        }
    </script>

    <div class="row-fluid">
        <div class="span1"></div>
        <div class="span10">
            <asp:UpdatePanel runat="server" id="UpdatePanel" updatemode="Conditional">
                <ContentTemplate>
                    <asp:Button runat="server" id="UpdateButton" onclick="UpdateButton_Click" text="Update" style="display:none;"/>
                    <asp:PlaceHolder runat="server" ID="UpdatePlaceholder" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:PlaceHolder runat="server" ID="StaticPlaceholder" />
            <asp:Image ID="imgBackground" CssClass="screen-bg" runat="server" />
        </div>   
        <div class="span1"></div>           
    </div>
</asp:Content>

