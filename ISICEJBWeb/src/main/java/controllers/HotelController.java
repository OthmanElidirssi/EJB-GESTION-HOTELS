package controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import jakarta.ejb.EJB;
import dao.IDaoLocale;
import entities.Hotel;
import entities.Ville;

/**
 * Servlet implementation class HotelController
 */
public class HotelController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB(beanName = "othman")
	private IDaoLocale<Hotel> ejb;

	@EJB(beanName = "kenza")
	private IDaoLocale<Ville> ejb2;

	public HotelController() {
		super();
		// TODO Auto-generated constructor stub

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action != null) {
			if (action.equals("delete")) {
				int hotelIdToDelete = Integer.parseInt(request.getParameter("hotelId"));
				Hotel hotelToDelete = ejb.findById(hotelIdToDelete);

				if (hotelToDelete != null) {
					ejb.delete(hotelToDelete);
				}
			}
		}

		List<Ville> villes = ejb2.findAll();
		for (Ville ville : villes) {
			System.out.println(ville.getNom());
		}

		request.setAttribute("villes", ejb2.findAll());
		request.setAttribute("hotels", ejb.findAll());
		RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String nom = request.getParameter("nom");
		String adresse = request.getParameter("adresse");
		String telephone = request.getParameter("telephone");
		String villeParameter = request.getParameter("ville");

		int villeId = Integer.parseInt(villeParameter);
		Ville selectedVille = ejb2.findById(villeId);
		ejb.create(new Hotel(nom, adresse, telephone, selectedVille));

		doGet(request, response);
	}
}