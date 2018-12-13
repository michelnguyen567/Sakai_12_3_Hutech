package websocket;

import java.io.*; 
import java.util.*; 
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;

@ServerEndpoint(
    value = "/story/notifications", 
    encoders = {StickerEncoder.class}, 
    decoders = {StickerDecoder.class})
public class StoryWebSocket {
	private static final List<Sticker> stickers = Collections.synchronizedList(new LinkedList<Sticker>()); 
	private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnMessage
	   public void onMessage(Session session, Sticker sticker) { 
			
					
	      if (sticker.getY()=="close")
	    	  for(Sticker opensticker: stickers){
	    			  if (opensticker.getX()==sticker.getX())
	    				  stickers.remove(opensticker);
	    	  }
	      else {
	    	  stickers.add(sticker);
	      }
	      for (Session openSession : sessions) { 
	         try { 
	        		 openSession.getBasicRemote().sendObject(sticker); 
	            
	         } catch (IOException | EncodeException ex) { 
	            sessions.remove(openSession); 
	         } 
	      } 
	   }
	@OnOpen
	   public void onOpen(Session session) throws IOException, EncodeException { 
		
		sessions.add(session); 
		for (Sticker opens: stickers){
			session.getBasicRemote().sendObject(opens);
		}
	       
	    } 

	   @OnClose
	   public void onClose(Session session) throws IOException, EncodeException { 
	      sessions.remove(session); 
	   } 
}
