-- button that changes text every time it is clicked made using FluentUi

local Fluent = require(game.ReplicatedStorage.FluentUi)
Fluent.mount(script.Parent)

-- ## variables

local clicked = 0

-- ## create components

Fluent.client.components.createComponent({
    Name = "MyButton",
    Styles = {
        Background = Color3.fromRGB(255, 255, 255);
        BorderRadius = 0.1;
        BoxShadow = true;
        Content = "Clicked: 0";
        ScaledFont = true;

        active = function(self)
            clicked = clicked + 1
            self.Text = "Clicked: " .. clicked
        end,
    }
})

-- ## render components

Fluent.client.components.addComponent({
    componentName = "MyButton",
    type = "TextButton",
    container = script.Parent
}, function(self)
    self.Size = UDim2.new(0.1, 0, 0.03, 0)
end)