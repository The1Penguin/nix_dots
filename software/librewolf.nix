{ config, lib, pkgs, Betterfox, ... }:

{
  programs.librewolf = {
    enable = true;
    profiles.default = {
      id = 1;
      isDefault = false;
      extensions.force = true;
    };
    profiles.pingu = {
      extensions.force = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        betterttv
        bitwarden
        consent-o-matic
        dearrow
        # enhancer-for-youtube
        firefox-color
        foxyproxy-standard
        new-tab-override
        old-reddit-redirect
        privacy-badger
        reddit-enhancement-suite
        refined-github
        shinigami-eyes
        sidebery
        sponsorblock
        stylus
        tampermonkey
        ublock-origin
        vimium
      ];
      extensions.settings = {
        "FirefoxColor@mozilla.com".settings = {
          firstRunDone = true;
          theme = {
            colors = {
              button_background_active = { b = 176; g = 160; r = 156; };
              frame = { b = 232; g = 224; r = 220; };
              frame_inactive = { b = 232; g = 224; r = 220; };
              icons = { b = 203; g = 118; r = 234; };
              icons_attention = { b = 203; g = 118; r = 234; };
              ntp_background = { b = 232; g = 224; r = 220; };
              ntp_text = { b = 105; g = 79; r = 76; };
              popup = { b = 245; g = 241; r = 239; };
              popup_border = { b = 203; g = 118; r = 234; };
              popup_highlight = { b = 176; g = 160; r = 156; };
              popup_highlight_text = { b = 105; g = 79; r = 76; };
              popup_text = { b = 105; g = 79; r = 76; };
              sidebar = { b = 245; g = 241; r = 239; };
              sidebar_border = { b = 203; g = 118; r = 234; };
              sidebar_highlight = { b = 203; g = 118; r = 234; };
              sidebar_highlight_text = { b = 232; g = 224; r = 220; };
              sidebar_text = { b = 105; g = 79; r = 76; };
              tab_background_separator = { b = 203; g = 118; r = 234; };
              tab_background_text = { b = 105; g = 79; r = 76; };
              tab_line = { b = 203; g = 118; r = 234; };
              tab_loading = { b = 203; g = 118; r = 234; };
              tab_selected = { b = 245; g = 241; r = 239; };
              tab_text = { b = 105; g = 79; r = 76; };
              toolbar = { b = 245; g = 241; r = 239; };
              toolbar_bottom_separator = { b = 245; g = 241; r = 239; };
              toolbar_field = { b = 239; g = 233; r = 230; };
              toolbar_field_border = { b = 245; g = 241; r = 239; };
              toolbar_field_border_focus = { b = 203; g = 118; r = 234; };
              toolbar_field_focus = { b = 245; g = 241; r = 239; };
              toolbar_field_highlight = { b = 203; g = 118; r = 234; };
              toolbar_field_highlight_text = { b = 245; g = 241; r = 239; };
              toolbar_field_separator = { b = 203; g = 118; r = 234; };
              toolbar_field_text = { b = 105; g = 79; r = 76; };
              toolbar_text = { b = 105; g = 79; r = 76; };
              toolbar_vertical_separator = { b = 203; g = 118; r = 234; };
            };
            images = {
              additional_backgrounds = [ "./bg-000.svg" ];
              custom_backgrounds = [ ];
              title = "Catppuccin latte pink";
            };
          };
        };
        "enhancerforyoutube@maximerf.addons.mozilla.org".settings = {
          controlbar = {
            active = false;
            autohide = false;
            centered = true;
            position = "fixed";
          };
          controls = [ ];
          pauseforegroundtab = false;
          hidecardsendscreens = true;
          miniplayer = false;
          theatermode = true;
          wideplayer = false;
          hidecomments = true;
          hidechat = true;
          hiderelated = true;
          hideshorts = true;
          convertshorts = true;
        };
        "newtaboverride@agenedia.com".settings = {
          url = "https://homepage.acorneroftheweb.com";
          focus_website = true;
        };
        "{3c078156-979c-498b-8990-85f7987dd929}".settings = {
          sidebar = {
            nav = [
              "history"
              "bookmarks"
              "tabs"
              "sp-0"
              "add_tp"
              "settings"
            ];
            panels = {
              "tabs" = {
                type = 2;
                id = "tabs";
                name = "Tabs";
                color = "toolbar";
                iconSVG = "icon_tabs";
                iconIMGSrc = "";
                iconIMG = "";
                lockedPanel = false;
                skipOnSwitching = false;
                noEmpty = false;
                newTabCtx = "none";
                dropTabCtx = "none";
                moveRules = [ ];
                moveExcludedTo = -1;
                bookmarksFolderId = -1;
                newTabBtns = [ ];
                srcPanelConfig = null;
              };
              "bookmarks" = {
                type = 1;
                id = "bookmarks";
                name = "Bookmarks";
                iconSVG = "icon_bookmarks";
                iconIMGSrc = "";
                iconIMG = "";
                color = "toolbar";
                lockedPanel = false;
                tempMode = false;
                skipOnSwitching = false;
                rootId = "root________";
                viewMode = "tree";
                autoConvert = false;
                srcPanelConfig = null;
              };
              history = {
                type = 4;
                id = "history";
                name = "History";
                color = "toolbar";
                iconSVG = "icon_clock";
                tempMode = false;
                lockedPanel = false;
                skipOnSwitching = false;
                viewMode = "history";
              };
            };
          };
          settings = {
            nativeScrollbars = false;
            nativeScrollbarsThin = true;
            nativeScrollbarsLeft = false;
            selWinScreenshots = false;
            updateSidebarTitle = true;
            markWindow = true;
            markWindowPreface = "🦊 ";
            ctxMenuNative = false;
            ctxMenuRenderInact = true;
            ctxMenuRenderIcons = true;
            ctxMenuIgnoreContainers = "";
            navBarLayout = "vertical";
            navBarInline = true;
            navBarSide = "left";
            hideAddBtn = false;
            hideSettingsBtn = false;
            navBtnCount = false;
            hideEmptyPanels = true;
            hideDiscardedTabPanels = false;
            navActTabsPanelLeftClickAction = "none";
            navActBookmarksPanelLeftClickAction = "none";
            navTabsPanelMidClickAction = "discard";
            navBookmarksPanelMidClickAction = "none";
            navSwitchPanelsWheel = true;
            subPanelRecentlyClosedBar = false;
            subPanelBookmarks = false;
            subPanelHistory = false;
            subPanelSync = false;
            groupLayout = "grid";
            containersSortByName = false;
            skipEmptyPanels = false;
            dndTabAct = true;
            dndTabActDelay = 750;
            dndTabActMod = "none";
            dndExp = "pointer";
            dndExpDelay = 750;
            dndExpMod = "none";
            dndOutside = "win";
            dndActTabFromLink = true;
            dndActSearchTab = true;
            dndMoveTabs = false;
            dndMoveBookmarks = false;
            searchBarMode = "dynamic";
            searchPanelSwitch = "same_type";
            searchBookmarksShortcut = "";
            searchHistoryShortcut = "";
            warnOnMultiTabClose = "collapsed";
            activateLastTabOnPanelSwitching = true;
            activateLastTabOnPanelSwitchingLoadedOnly = true;
            switchPanelAfterSwitchingTab = "always";
            tabRmBtn = "hover";
            activateAfterClosing = "next";
            activateAfterClosingStayInPanel = false;
            activateAfterClosingGlobal = false;
            activateAfterClosingNoFolded = true;
            activateAfterClosingNoDiscarded = true;
            askNewBookmarkPlace = true;
            tabsRmUndoNote = true;
            tabsUnreadMark = false;
            tabsUpdateMark = "all";
            tabsUpdateMarkFirst = true;
            tabsReloadLimit = 5;
            tabsReloadLimitNotif = true;
            showNewTabBtns = false;
            newTabBarPosition = "after_tabs";
            tabsPanelSwitchActMove = true;
            tabsPanelSwitchActMoveAuto = true;
            tabsUrlInTooltip = "full";
            newTabCtxReopen = false;
            tabWarmupOnHover = true;
            tabSwitchDelay = 0;
            forceDiscard = true;
            moveNewTabPin = "start";
            moveNewTabParent = "last_child";
            moveNewTabParentActPanel = false;
            moveNewTab = "end";
            moveNewTabActivePin = "start";
            pinnedTabsPosition = "panel";
            pinnedTabsList = false;
            pinnedAutoGroup = false;
            pinnedNoUnload = false;
            pinnedForcedDiscard = false;
            tabsTree = true;
            groupOnOpen = true;
            tabsTreeLimit = "none";
            autoFoldTabs = false;
            autoFoldTabsExcept = "none";
            autoExpandTabs = false;
            autoExpandTabsOnNew = false;
            rmChildTabs = "folded";
            tabsLvlDots = true;
            discardFolded = false;
            discardFoldedDelay = 0;
            discardFoldedDelayUnit = "sec";
            tabsTreeBookmarks = true;
            treeRmOutdent = "branch";
            autoGroupOnClose = false;
            autoGroupOnClose0Lvl = false;
            autoGroupOnCloseMouseOnly = false;
            ignoreFoldedParent = false;
            showNewGroupConf = true;
            sortGroupsFirst = true;
            colorizeTabs = false;
            colorizeTabsSrc = "domain";
            colorizeTabsBranches = true;
            colorizeTabsBranchesSrc = "url";
            inheritCustomColor = true;
            previewTabs = false;
            previewTabsMode = "p";
            previewTabsPageModeFallback = "n";
            previewTabsInlineHeight = 70;
            previewTabsPopupWidth = 280;
            previewTabsTitle = 2;
            previewTabsUrl = 1;
            previewTabsSide = "right";
            previewTabsDelay = 500;
            previewTabsFollowMouse = true;
            previewTabsWinOffsetY = 36;
            previewTabsWinOffsetX = 6;
            previewTabsInPageOffsetY = 0;
            previewTabsInPageOffsetX = 0;
            previewTabsCropRight = 0;
            hideInact = false;
            hideFoldedTabs = false;
            hideFoldedParent = "none";
            nativeHighlight = true;
            warnOnMultiBookmarkDelete = "collapsed";
            autoCloseBookmarks = false;
            autoRemoveOther = false;
            highlightOpenBookmarks = false;
            activateOpenBookmarkTab = false;
            showBookmarkLen = true;
            bookmarksRmUndoNote = true;
            loadBookmarksOnDemand = true;
            pinOpenedBookmarksFolder = true;
            oldBookmarksAfterSave = "ask";
            loadHistoryOnDemand = true;
            fontSize = "xxs";
            animations = false;
            animationSpeed = "norm";
            theme = "proton";
            density = "compact";
            colorScheme = "ff";
            snapNotify = true;
            snapExcludePrivate = false;
            snapInterval = 0;
            snapIntervalUnit = "min";
            snapLimit = 0;
            snapLimitUnit = "snap";
            snapAutoExport = false;
            snapAutoExportType = "json";
            snapAutoExportPath = "Sidebery/snapshot-%Y.%M.%D-%h.%m.%s";
            snapMdFullTree = false;
            hScrollAction = "none";
            onePanelSwitchPerScroll = false;
            wheelAccumulationX = true;
            wheelAccumulationY = true;
            navSwitchPanelsDelay = 128;
            scrollThroughTabs = "none";
            scrollThroughVisibleTabs = true;
            scrollThroughTabsSkipDiscarded = true;
            scrollThroughTabsExceptOverflow = true;
            scrollThroughTabsCyclic = false;
            scrollThroughTabsScrollArea = 0;
            autoMenuMultiSel = true;
            multipleMiddleClose = false;
            longClickDelay = 500;
            wheelThreshold = false;
            wheelThresholdX = 10;
            wheelThresholdY = 60;
            tabDoubleClick = "none";
            tabsSecondClickActPrev = false;
            tabsSecondClickActPrevPanelOnly = false;
            tabsSecondClickActPrevNoUnload = false;
            shiftSelAct = true;
            activateOnMouseUp = false;
            tabLongLeftClick = "none";
            tabLongRightClick = "none";
            tabMiddleClick = "close";
            tabPinnedMiddleClick = "discard";
            tabMiddleClickCtrl = "discard";
            tabMiddleClickShift = "duplicate";
            tabCloseMiddleClick = "close";
            tabsPanelLeftClickAction = "none";
            tabsPanelDoubleClickAction = "tab";
            tabsPanelRightClickAction = "menu";
            tabsPanelMiddleClickAction = "tab";
            newTabMiddleClickAction = "new_child";
            bookmarksLeftClickAction = "open_in_act";
            bookmarksLeftClickActivate = false;
            bookmarksLeftClickPos = "default";
            bookmarksMidClickAction = "open_in_new";
            bookmarksMidClickActivate = false;
            bookmarksMidClickRemove = false;
            bookmarksMidClickPos = "default";
            historyLeftClickAction = "open_in_act";
            historyLeftClickActivate = false;
            historyLeftClickPos = "default";
            historyMidClickAction = "open_in_new";
            historyMidClickActivate = false;
            historyMidClickPos = "default";
            syncName = "";
            syncUseFirefox = false;
            syncUseGoogleDrive = false;
            syncUseGoogleDriveApi = false;
            syncUseGoogleDriveApiClientId = "";
            syncSaveSettings = false;
            syncSaveCtxMenu = false;
            syncSaveStyles = false;
            syncSaveKeybindings = false;
            selectActiveTabFirst = true;
            selectCyclic = false;
          };
          sidebarCSS = lib.readFile ../files/sidebery.css;
        };
        "sponsorBlocker@ajay.app".settings = { navigationApiAvailable = false; };
        "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = { dbInChromeStorage = true; };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}".settings = {
          normalModeKeyStateMapping = {
            j = { command = "scrollDown"; options = { }; };
            k = { command = "scrollUp"; options = { }; };
            h = { command = "scrollLeft"; options = { }; };
            l = { command = "scrollRight"; options = { }; };
            g = {
              "0" = { command = "firstTab"; background = true; options = { }; };
              g = { command = "scrollToTop"; options = { }; };
              i = { command = "focusInput"; options = { }; };
              f = { command = "nextFrame"; background = true; options = { }; };
              F = { command = "mainFrame"; noRepeat = true; topFrame = true; options = { }; };
              u = { command = "goUp"; options = { }; };
              U = { command = "goToRoot"; options = { }; };
              e = { command = "Vomnibar.activateEditUrl"; topFrame = true; options = { }; };
              E = { command = "Vomnibar.activateEditUrlInNewTab"; topFrame = true; options = { }; };
              t = { command = "nextTab"; background = true; options = { }; };
              T = { command = "previousTab"; background = true; options = { }; };
              "$" = { command = "lastTab"; background = true; options = { }; };
              s = { command = "toggleViewSource"; noRepeat = true; options = { }; };
            };
            G = { command = "scrollToBottom"; options = { }; };
            z = {
              "0" = { command = "zoomReset"; background = true; options = { }; };
              H = { command = "scrollToLeft"; options = { }; };
              L = { command = "scrollToRight"; options = { }; };
              i = { command = "zoomIn"; background = true; options = { }; };
              o = { command = "zoomOut"; background = true; options = { }; };
            };
            d = { command = "scrollPageDown"; options = { }; };
            u = { command = "scrollPageUp"; options = { }; };
            r = { command = "reload"; background = true; options = { }; };
            R = { command = "reload"; background = true; options = { hard = true; }; };
            y = {
              y = { command = "copyCurrentUrl"; noRepeat = true; options = { }; };
              f = { command = "LinkHints.activateModeToCopyLinkUrl"; options = { }; };
              t = { command = "duplicateTab"; repeatLimit = 20; background = true; options = { }; };
            };
            "[" = { "[" = { command = "goPrevious"; noRepeat = true; options = { }; }; };
            "]" = { "]" = { command = "goNext"; noRepeat = true; options = { }; }; };
            i = { command = "enterInsertMode"; noRepeat = true; options = { }; };
            v = { command = "enterVisualMode"; noRepeat = true; options = { }; };
            V = { command = "enterVisualLineMode"; noRepeat = true; options = { }; };
            f = { command = "LinkHints.activateMode"; options = { }; };
            F = { command = "LinkHints.activateModeToOpenInNewTab"; options = { }; };
            "<a-f>" = { command = "LinkHints.activateModeWithQueue"; noRepeat = true; options = { }; };
            "/" = { command = "enterFindMode"; noRepeat = true; options = { }; };
            n = { command = "performFind"; options = { }; };
            N = { command = "performBackwardsFind"; options = { }; };
            "*" = { command = "findSelected"; options = { }; };
            "#" = { command = "findSelectedBackwards"; options = { }; };
            o = { command = "Vomnibar.activate"; topFrame = true; options = { }; };
            O = { command = "Vomnibar.activateInNewTab"; topFrame = true; options = { }; };
            H = { command = "goBack"; options = { }; };
            L = { command = "goForward"; options = { }; };
            K = { command = "previousTab"; background = true; options = { }; };
            J = { command = "nextTab"; background = true; options = { }; };
            "^" = { command = "visitPreviousTab"; background = true; options = { }; };
            "<" = { "<" = { command = "moveTabLeft"; background = true; options = { }; }; };
            ">" = { ">" = { command = "moveTabRight"; background = true; options = { }; }; };
            W = { command = "moveTabToNewWindow"; background = true; options = { }; };
            t = { command = "createTab"; repeatLimit = 20; background = true; options = { }; };
            x = { command = "removeTab"; repeatLimit = 25; background = true; options = { }; };
            X = { command = "restoreTab"; repeatLimit = 20; background = true; options = { }; };
            "<a-p>" = { command = "togglePinTab"; background = true; options = { }; };
            "<a-m>" = { command = "toggleMuteTab"; noRepeat = true; background = true; options = { }; };
            m = { command = "Marks.activateCreateMode"; noRepeat = true; options = { }; };
            "`" = { command = "Marks.activateGotoMode"; noRepeat = true; options = { }; };
            "?" = { command = "showHelp"; noRepeat = true; topFrame = true; options = { }; };
          };
          useVimLikeEscape = true;
        };
      };
      isDefault = true;
      userChrome = (builtins.readFile ../files/firefox.css);
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
      extraConfig = (builtins.readFile "${Betterfox}/user.js");
      search = {
        engines = {
          "Acorneroftheweb.com" = {
            urls = [{
              template = "https://search.acorneroftheweb.com/search?q={searchTerms}";
            }];
          };
          "google".metaData.hidden = true;
          "duckduckgo-lite".metaData.hidden = true;
          "meta-ger".metaData.hidden = true;
          "mojeek".metaData.hidden = true;
          "searxng".metaData.hidden = true;
          "startpage".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
        default = "Acorneroftheweb.com";
        force = true;
      };
    };
  };
}
