# Fluent Ui

Fluent is a Roblox ui framework that allows the creation of GUIs from CSS like style values.

Below is a list of (almost) all currently supported values:

## Values

Every value has a default that will be used if it is not set.

### Supported By All
- BorderRadius: **Number**
- isFlex: **Boolean**
    - alignX: **Left (Default) | Center | Right**
    - alignY: **Top (Default) | Center | Bottom**
    - flexOrder: **Name (Default) | LayoutOrder**
    - flexPadding: **Udim (Default: 0)**
- Border: **Boolean**
    - BorderApplyMode: **Contextual (Default) | Border**
    - BorderJoinMode: **Round (Default) | Bevel | Miter**
    - BorderThickness: **Number (Default: 1)**
    - BorderOpacity: **Number (Default: 0)**
    - BorderColor: **Color3 (Default: 0, 0, 0)**
- BoxShadow: **Boolean**
    - boxShadowStyle: **Number: 1 (Default) | 2**
    - boxShadowAlpha: **Number**
- Padding: **Boolean**
    - PaddingTop: **Number**
    - PaddingBottom: **Number**
    - PaddingLeft: **Number**
    - PaddingRight: **Number**
- Opacity: **Number (Default: Inherit)**
- Name: **String (Default: Inherit)**
- Pos: **Udim2 (Default: Inherit)**
- Background: **Color3 (Default: Inherit)**
- sizeX: **Number (Default: SKIP) (Relative)**
- sizeY: **Number (Default: SKIP) (Relative)**

### Text Objects
- isRichText: **Boolean (Default: Inherit)**
- Content: **String (Default: Inherit)**
- ScaledFont: **Boolean (Default: Inherit)**
- Color: **Color3 (Default: Inherit)**
- FontFamily: **Enum.Font**

### TextButton
- autoColor: **Boolean (Default: false)**
#### Events
- active: **function** fires on *MouseButton1Click*

## Events

- onhover: **function(self)** fires when the mouse enters the component
- onunhover: **function(self)** fires when the mouse exits the component
- run: **function(script, self)** runs a localscript on the client from the component 

## Defaults

Below is the default style sheet included in FluentUi. All defined styles can be overwritten.

```js
{
    FluentButton = {
        Background = Color3.fromRGB(255, 255, 255);
        BorderRadius = 0.15;
        BoxShadow = true;
        ScaledFont = true;

        sizeX = 0.15;
        sizeY = 0.03;

        active = function(self)
            TweenService:Create(self, TweenInfo.new(0.05), {BackgroundTransparency = 0.2}):Play()
            wait(0.04); TweenService:Create(self, TweenInfo.new(0.05), {BackgroundTransparency = 0.1}):Play()
        end,

        onhover = function(self)
            TweenService:Create(self, TweenInfo.new(0.05), {BackgroundTransparency = 0.1}):Play()
        end, onunhover = function(self)
            TweenService:Create(self, TweenInfo.new(0.05), {BackgroundTransparency = 0}):Play()
        end,
    }
}
```