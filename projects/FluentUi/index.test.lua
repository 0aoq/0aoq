local Fluent = require(game.ReplicatedStorage.FluentUi)

Fluent.render(script.Parent, {
    test = {
        BorderRadius = UDim.new(1, 0)
    }
})

Fluent.client.components.createComponent({
    Name = "mainGui",
    Styles = {
        Background = Color3.fromRGB(255, 255, 255);
        BorderRadius = UDim.new(0.1, 0);
        pos = UDim2.new(0, 0, 0, 0);
        
        sizeX = 0.1;
        sizeY = 0.2
    }
})

Fluent.client.components.addComponent({
    componentName = "mainGui",
    type = "Frame",
    container = script.Parent
})