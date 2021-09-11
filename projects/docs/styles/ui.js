const ui = {
    render: function() {
        console.log("ui.js: Beginning render process.")

        document.head.insertAdjacentHTML("beforeend", `
            <!-- =================== -->
            <!-- ui.js bundle        -->
            <!-- =================== -->

            <style>
                * {
                    margin: 0;
                }

                .ui-js {
                    display: block;
                }

                /* =================== */
                /* DATA TYPES          */
                /* =================== */

                .ui-js .ui-fixed-nav {
                    position: fixed !important;
                    top: 0 !important;
                    left: 0;
                    right: 0;
                    z-index: 5;
                }

                .ui-js .ui-floating-bottom {
                    position: fixed !important;
                    bottom: 30px;
                    left: 20px;
                }

                .ui-js .ui-top-right-wrapper {
                    position: fixed !important;
                    top: 3rem;
                    right: 3rem;
                    z-index: 10;
                }

                .ui-js .ui-bottom-right-wrapper {
                    position: fixed !important;
                    bottom: .1rem;
                    right: 3rem;
                    z-index: 10;
                }

                .ui-js .ui-alert {
                    width: 100%;
                    background: rgba(255, 234, 117, 0.226);
                    border-left: rgb(255, 234, 117) solid 5px;
                    padding: 2px;
                    padding-left: 20px;
                    margin-bottom: 20px;
                }

            </style>

            <!-- ui.js stylesheets -->

            <link rel="stylesheet" href="styles/ui.js_styles/styles.css">
            <link rel="stylesheet" href="styles/ui.js_styles/elements.css">
        `)

        if (document.querySelectorAll(".ui-js").length <= 0) {
            console.log("ui.js: No ui-js class element found.")
        } else {
            console.log("ui.js: Rendered.")
        }
    },
    bodycontent: function(content, loadingScreen) {
        let $

        $ = content.innerHTML
        content.innerHTML = ""

        setTimeout(() => {
            content.innerHTML = $

            loadingScreen.style.background = "none"
            loadingScreen.style["z-index"] = 0
            setTimeout(() => {
                loadingScreen.remove()
            }, 1000);
        }, 500);
    }
}

console.log("ui.js: Loaded.")

if (document.querySelector('script[src="styles/ui.js"][ui-autorender]')) {
    ui.render()
    ui.bodycontent(
        document.getElementById("ui-js__main-content"),
        document.getElementById("ui-js__loading-screen")
    )
}