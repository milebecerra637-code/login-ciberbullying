
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/consultarEstado")
public class ConsultarEstadoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String codigo = request.getParameter("codigoReporte");

        if (codigo == null || codigo.trim().isEmpty()) {
            request.setAttribute("mensaje", "Por favor, ingresa un código válido.");
            request.getRequestDispatcher("/consultarestado.jsp").forward(request, response);
            return;
        }

        // Simulación de búsqueda
        String estado = null;
        if (codigo.equalsIgnoreCase("REP-2025-001")) {
            estado = "En revisión por el comité escolar";
        } else if (codigo.equalsIgnoreCase("REP-2025-002")) {
            estado = "Caso cerrado";
        }

        if (estado != null) {
            request.setAttribute("mensaje", "Consulta exitosa ✅");
            request.setAttribute("estado", estado);
        } else {
            request.setAttribute("mensaje", "⚠️ No se encontró un caso con ese código.");
        }

        request.getRequestDispatcher("/consultarestado.jsp").forward(request, response);
    }
}
