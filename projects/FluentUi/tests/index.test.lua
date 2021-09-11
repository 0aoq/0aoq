local Fluent = require(game.ReplicatedStorage.FluentUi)

Fluent.mount(script.Parent)

-- style components

Fluent.client.components.createComponent({
    Name = "align",
    Styles = {
        sizeX = 1;
        sizeY = 1;
        pos = UDim2.new(0, 0, 0, 0);
        Opacity = 1;

        isFlex = true;
        alignX = "Center";
        alignY = "Center",
    }
})

Fluent.client.components.createComponent({
    Name = "mainGui",
    Styles = {
        Background = Color3.fromRGB(255, 255, 255);
        BorderRadius = 0.05;
        pos = UDim2.new(0, 0, 0, 0);
        BoxShadow = true;

        sizeX = 0.1;
        sizeY = 0.2;
        
        Border = true;
        BorderThickness = 5;
        BorderOpacity = 0.5;
        BorderColor = Color3.fromRGB(10, 161, 255)
    }
})

-- add components

local app = Fluent.client.components.addComponent({
    componentName = "align",
    type = "Frame",
    container = script.Parent
})

Fluent.client.components.addComponent({
    name = "gui",
    componentName = "mainGui",
    type = "Frame",
    container = app
})
