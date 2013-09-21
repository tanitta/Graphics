namespace "trit"{
	namespace"graphics"{
		class "SmirnoffPen"{
			metamethod "_init"
			:body(
				function(self,color, width)
					self.hanGDI = CreatePen(color, width)
					self.width = width or 1
					self.color = color

					self.hanScreen = nil
				end
			);
			
			method "SetHanScreen"
			:body(
				function(self, han)
					self.hanScreen = han
				end
			);

			--í∑ï˚å`ÇÃâèÇï`âÊ
			method "DrawRectangle"
			:body(
				function(self, x, y, width, height)
					SelectObject(self.hanScreen,self.hanGDI)
					DrawRectangle(self.hanScreen, x, y, width, height)
				end
			);

			method "SetColor"
			:body(
				function(self, color)
					DeleteObject(self.hanGDI)
					self.hanGDI = CreatePen(color, self.width)
					self.color = color
				end
			);

			method "GetHanGDI"
			:body(
				function (self)
					return self.hanGDI
				end
			);

			method "MoveTo"
			:body(
				function(self, x, y)
					SelectObject(self.hanScreen, self.hanGDI)
					MoveTo(self.hanScreen, x, y)
				end
			);

			--íºê¸Çï`âÊÇ∑ÇÈÇ∆Ç∆Ç‡Ç…ÉJÉåÉìÉgÉ|ÉWÉVÉáÉìÇà⁄ìÆÇ∑ÇÈ
			method "LineTo"
			:body(
				function(self, x, y)
					SelectObject(self.hanScreen, self.hanGDI)
					LineTo(self.hanScreen, x, y)
				end
			);

			metamethod "__call"
			:body(
				function(self, x, y, width, height)
					SelectObject(self.hanScreen, self.hanGDI)
					DrawRectangle(self.hanScreen, x, y, width, height)
				end
			);
		};

		class "SmirnoffBrush"{
			metamethod "_init"
			:body(
				function(self,color)

					self.hanGDI = CreateBrush(color)
					self.color = color

					self.hanScreen = nil
				end
			);

			method "SetHanScreen"
			:body(
				function(self, han)
					self.hanScreen = han
				end
			);

			method "SetColor"
			:body(
				function(self, color)
					DeleteObject(self.hanGDI)
					self.hanGDI = CreateBrush(color)
					self.color = color
				end
			);

			--í∑ï˚å`ÇìhÇËÇ¬Ç‘Çµï`âÊ
			method "FillRectangle"
			:body(
				function(self, x, y, width, height)
					SelectObject(self.hanScreen,self.hanGDI)
					FillRectangle(self.hanScreen, x, y, width, height)
				end
			);


			method "GetHanGDI"
			:body(
				function (self)
					return self.hanGDI
				end
			);

			metamethod "__call"
			:body(
				function(self, x, y, width, height)
					SelectObject(self.hanScreen, self.hanGDI)
					FillRectangle(self.hanScreen, x, y, width, height)
				end
			);
		};

		class "SmirnoffFont"{
			metamethod "_init"
			:body(
				function(self,size,isBoid)
					self.hanGDI = CreateFont(size, isBold or false)
					self.color = 0
					self.hanScreen = nil
				end
			);
			method "GetHanGDI"
			:body(
				function (self)
					return self.hanGDI
				end
			);

			method "SetHanScreen"
			:body(
				function(self, han)
					self.hanScreen = han
				end
			);

			method "SetColor"
			:body(
				function(self, color)
					self.color = color
				end
			);

			metamethod "__call"
			:body(
				function(self, x, y, string)
					SelectObject(self.hanScreen, self.hanGDI )
					DrawText(self.hanScreen, x, y, self.color, string)
				end
			);
		};

		class "SmirnoffWindow"{
			metamethod "_init"
			:body(
				function (self, strname)
					self.numVersion = SMIRNOFF_VERSION;
					self.strName = strname or "" 
				end
			);

			method "swCreate"
			:body(
				function (self, width, height)
						self.hanWindow = CreateWindow(width, height, self.strName)
						self.hanScreen = CreateScreen(self.hanWindow, width, height)
						
						self.swWidth, self.swHeight = self:swGetWindowSize()
						
						self.swPen = trit.graphics.SmirnoffPen:new(hsv(0,0,0),1)
						self.swBrush = trit.graphics.SmirnoffBrush:new(hsv(0,0,0))
						self.swFont = trit.graphics.SmirnoffFont:new(12,false)
						
						self.swPen:SetHanScreen(self.hanScreen)
						self.swBrush:SetHanScreen(self.hanScreen)
						self.swFont:SetHanScreen(self.hanScreen)

						self.colBackground = hsv(0,0,0)

				end
			);

			method "swDestroy"
			:body(
				function (self)
					DestroyWindow(self.hanWindow)
				end
			);

			method "swMove"
			:body(
				function (self, x, y)
					MoveWindow(self.hanWindow, x, y)
				end
			);

			method "swGetPos"
			:body(
				function (self)
					return GetWindowPos(self.hanWindow)
				end
			);

			method "swResize"
			:body(
				function (self)
					--ResizeWindow?(WindowHandle?, width, height)
				end
			);

			method "swGetHanScreen"
			:body(
				function (self)
					return self.hanScreen
				end
			);

			method "swGetHanWindow"
			:body(
				function (self)
					return self.hanWindow
				end
			);

			method "swGetWindowSize"
			:body(
				function(self)
					return GetWindowSize(self.hanWindow)
				end
			);

			method "swGetMousePosition"
			:body(
				function(self)
					return GetMousePosition(self.hanWindow)
				end
			);
			
			method"swSetBackground"
			:body(
				function(self,col)
					self.colBackground = col
				end
			);
			
			
			method"swSetColor"
			:body(
				function(self,col)
					self.swBrush:SetColor(col)
					self.swPen:SetColor(col)
					self.swFont:SetColor(col)
					
				end
			);
			
			method"swIsWindowActive"
			:body(
				function(self)
					return IsWindowActive(self.hanWindow)
				end
			);
			
			
			method"Init"
			:body(
				function(self)
				end
			);
			
			
			method"Call"
			:body(
				function(self)
				end
			);
			
			
			method"Draw"
			:body(
				function(self)
				end
			);
			

			metamethod "__call"
			:body(
				function (self)
					self:swSetColor(self.colBackground)
					local w,h = self:swGetWindowSize() 
					self.swBrush(0,0,w,h)
					
					self:Call();
					self:Draw();
					
					if GetWindowState(self.hanWindow) == 1 then
						BitBlt(self.hanWindow, self.hanScreen, 0, 0)
					end
					
				end
			);

		};
	};
};