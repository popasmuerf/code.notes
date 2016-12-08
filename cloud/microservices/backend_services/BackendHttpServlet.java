public class BackendHttpServlet extends HttpServlet{
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
                resp.setContentType("applications/json");
        }
        private String getIp(){
                String hostname = null ;
                try{
                        hostname = InetAddress.getLocalHost().getLocalHost().getHostAddress() ;
                }catch(UnknownHostException e){
                        hostname = "unknown" ;
                }
                return hostname ;
        }

}
