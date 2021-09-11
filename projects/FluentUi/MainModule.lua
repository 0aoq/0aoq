local _0aoq_fluent = {}; do
    _G.FluentUi = {
        name = "FluentUi",
        author = "0a_oq"
    }
    
    local CLASS_NAME = "FLUENT_UI_CLASS"

    -- types

    export type fluent_component = {
        Name: string,
        Styles: {}
    }

    export type fluent_component_config = {
        componentName: string,
        name: string,
        type: string,
        container: any
    }

    -- module
    local internal = {}; do
        internal.styleSheet = {}

        -- table of all values WITH A FUNCTION TO CALL
        internal.styles = {"BorderRadius", "isFlex", "BoxShadow", "Padding"}

        -- style functions
        internal.styleValues = {}; do
            internal.styleValues.isFlex = function(component, style) -- @fluent_style:isFlex
                style.flexOrder = style.flexOrder or "Name"; style.alignX = style.alignX or "Left"
                style.alignY = style.alignY or "Top"; style.flexPadding = style.flexPadding or 0

                if (not component:FindFirstChild("FLUENT_LIST_LAYOUT")) then
                    local UiListLayout = Instance.new("UIListLayout", component)
                    UiListLayout.Name = "FLUENT_LIST_LAYOUT"
                    UiListLayout.HorizontalAlignment = Enum.HorizontalAlignment[style.alignX]
                    UiListLayout.VerticalAlignment = Enum.VerticalAlignment[style.alignY]
                    UiListLayout.SortOrder = Enum.SortOrder[style.flexOrder]
                    UiListLayout.Padding = UDim.new(style.flexPadding or 0, 0)
                end
            end; internal.styleValues.BoxShadow = function(component, style) -- @fluent_style:BoxShadow
                local frame = Instance.new("Frame", component.Parent)
                component.Parent = frame
                frame.Name = component.Name
                frame.Size = component.Size
                frame.Position = component.Position
                frame.BackgroundTransparency = 1
                component.Size = UDim2.new(1, 0, 1, 0)
                component.Position = UDim2.new(0, 0, 0, 0)

                local boxshadow = Instance.new("ImageLabel", frame)

                style.boxShadowStyle = style.boxShadowStyle or 1
                if style.boxShadowStyle == 1 then
                    boxshadow.Image = "rbxassetid://6919135242"

                    if frame.Size.Y.Scale > 0.5 then
                        boxshadow.Size = component.Size + UDim2.new(0.3, 0, 0.4, 0)
                        boxshadow.ImageTransparency = style.boxShadowAlpha or 0
                    else -- normal box shadow doesn't look good with objects that are too small
                        boxshadow.Size = component.Size + UDim2.new(0.4, 0, 0.5, 0)
                        boxshadow.ImageTransparency = style.boxShadowAlpha or 0.5
                    end

                    boxshadow.Position = component.Position + UDim2.new(-0.2, 0, -0.2, 0)
                else
                    boxshadow.Image = "rbxassetid://6916236943"

                    if frame.Size.Y.Scale > 0.5 then
                        boxshadow.Size = component.Size + UDim2.new(0.2, 0, 0.2, 0)
                        boxshadow.ImageTransparency = style.boxShadowAlpha or 0
                    else -- normal box shadow doesn't look good with objects that are too small
                        boxshadow.Size = component.Size + UDim2.new(0.2, 0, 0.3, 0)
                        boxshadow.ImageTransparency = style.boxShadowAlpha or 0.65
                    end

                    boxshadow.Position = component.Position + UDim2.new(-0.1, 0, -0.1, 0)
                end

                boxshadow.Name = "BoxShadow"
                boxshadow.BackgroundTransparency = 1
                component.ZIndex = component.ZIndex + 1
                boxshadow.ZIndex = component.ZIndex - 1
                frame.ZIndex = component.ZIndex
            end; internal.styleValues.BorderRadius = function(component, style) -- @fluent_style:BorderRadius
                Instance.new("UICorner", component).CornerRadius = UDim.new(style.BorderRadius or 0, 0)
            end; internal.styleValues.padding = function(component, style)
                local tempInstance = Instance.new("UIPadding", component); do
                    tempInstance.PaddingTop = UDim.new(style.PaddingTop, 0)
                    tempInstance.PaddingBottom = UDim.new(style.PaddingBottom, 0)

                    tempInstance.PaddingLeft = UDim.new(style.PaddingLeft, 0)
                    tempInstance.PaddingRight = UDim.new(style.PaddingRight, 0)
                end
            end
        end

        internal.styleComponent = function(component, style)
            if (style == nil) then return end

            -- Styles

            component.BackgroundColor3 = style.Background or component.BackgroundColor3
            component.Position = style.pos or component.Position
            component.Name = style.name or component.Name
            component.BackgroundTransparency = style.Opacity or component.BackgroundTransparency

            if (style.sizeX and style.sizeY) then -- set size
                component.Size = UDim2.new(style.sizeX , 0, style.sizeY, 0)
            end

            component.Visible = not style.hidden or not false

            for _,x in pairs(internal.styles) do
                if (style[x] == true) then internal.styleValues[x](component, style) end
            end

            -- @this Handle button specific properties
            if (component:IsA("TextButton")) then
                component.MouseButton1Click:Connect(style.active or function() end)
                component.AutoButtonColor = style.autoColor
            end

            -- @this Handle text related properties
            style.fontFamily = style.fontFamily or "SourceSans"
            if (component:IsA("TextLabel") or component:IsA("TextButton")) then
                component.RichText = style.rich or component.RichText
                component.Text = style.content or component.Text
                component.TextScaled = style.scaledText or component.TextScaled
                component.TextColor3 = style.color or component.TextColor3
                component.Font = Enum.Font[style.fontFamily]
            end

            -- Events

            if (style.onhover) then
                component.MouseEnter:Connect(function()
                    coroutine.wrap(style.onhover)(component)
                end)
            end

            if (style.onunhover) then
                component.MouseLeave:Connect(function()
                    coroutine.wrap(style.onunhover)(component)
                end)
            end

            if (style.active) then
                if component:IsA("TextButton") then
                    component.MouseButton1Click:Connect(function()
                        coroutine.wrap(style.active)(component, style)
                    end)
                end
            end

            if (style.run) then
                coroutine.wrap(style.run)(Instance.new("LocalScript", component), component)
            end
        end
    end

    _0aoq_fluent.client = {}; do
        internal.renderedContainers = {}
        internal.components = {}

        _0aoq_fluent.bin = {}; do
            _0aoq_fluent.bin.getStyle = function(name: string)
                return internal.styleSheet[name]
            end
        end

        internal.scanContainer = function(container, styles, isComponent: boolean)
            if (styles ~= internal.styleSheet) then
                -- if (isComponent) then table.insert(internal.styleSheet, 1, styles) end
                table.insert(internal.renderedContainers, 1, container)
            end

            for _,component in pairs(container:GetDescendants()) do
                if (not component:IsA("LocalScript")) then
                    internal.styleComponent(component, _0aoq_fluent.bin.getStyle(component:GetAttribute(CLASS_NAME)))
                end
            end
        end

        _0aoq_fluent.render = function(container, styles) internal.scanContainer(container, styles, false) end

        -- @function Returns a table of all elements that match a className
        _0aoq_fluent.getElementsByClassName = function(container, className)
            if (not internal.styleSheet) then return warn("[Fluent]: Styles have not been rendered!") end
            local elements = {}

            for _,component in pairs(container:GetDescendants()) do
                if component:GetAttribute("FLUENT_UI_CLASS") == className then
                    table.insert(elements, 1, component)
                end
            end

            return elements
        end

        -- @function Get the element that is the specific number in the list
        _0aoq_fluent.nthChild = function(container, className, x, style)
            if (not internal.styleSheet) then return warn("[Fluent]: Styles have not been rendered!") end
            for i,v in pairs(_0aoq_fluent.getElementsByClassName(container, className)) do
                if (i == x) then
                    internal.styleComponent(v, style)
                    v:SetAttribute("FLUENT_UI_CLASS", v:GetAttribute("FLUENT_UI_CLASS") .. i)
                end
            end
        end

        -- /// START SECTION: component handling
        _0aoq_fluent.client.components = {}; do
            _0aoq_fluent.client.components.createComponent = function(component: fluent_component)
                if (not internal.styleSheet) then return warn("[Fluent]: Styles have not been rendered!") end

                for _,x in pairs(internal.renderedContainers) do
                    internal.components[component.Name] = component
                    internal.styleSheet[component.Name] = component.Styles

                    internal.scanContainer(x, internal.styleSheet, true)
                end
            end

            _0aoq_fluent.client.components.addComponent = function(
                componentConfig: fluent_component_config
            )
                if (not internal.styleSheet) then return warn("[Fluent]: Styles have not been rendered!") end

                local __ = Instance.new(componentConfig.type, componentConfig.container)
                __.Name = componentConfig.name or "FLUENT_COMPONENT:" .. componentConfig.type
                __:SetAttribute("FLUENT_UI_CLASS", componentConfig.componentName)

                local style = _0aoq_fluent.bin.getStyle(componentConfig.name)
                internal.scanContainer(componentConfig.container, style, true)
                internal.styleComponent(__, style)

                return __
            end

            _0aoq_fluent.client.components.removeComponent = function(componentName: string)
                for _,x in pairs(internal.components) do
                    if (x == componentName) then
                        internal.components[x] = nil
                    end
                end
            end
        end
    end
    -- /// END SECTION: component handling

    _0aoq_fluent.client.test = function()
        local function ENCODE(json) return game:GetService("HttpService"):JSONEncode(json) end
        return ENCODE(internal.styleSheet), ENCODE(internal.components)
    end
end; return _0aoq_fluent
