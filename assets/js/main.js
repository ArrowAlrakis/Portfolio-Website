document.addEventListener("DOMContentLoaded", () => {
    // menu code
    const menuToggle = document.querySelector(".menu-toggle");
    const siteNav = document.querySelector(".site-nav");

    if (menuToggle && siteNav) {
        menuToggle.addEventListener("click", () => {
            siteNav.classList.toggle("show");

            const isExpanded = menuToggle.getAttribute("aria-expanded") === "true";
            menuToggle.setAttribute("aria-expanded", String(!isExpanded));
        });
    }

    // filter code
    const filterButtons = document.querySelectorAll(".filter-btn");
    const projectCards = document.querySelectorAll(".filterable-card");
    if (filterButtons.length && projectCards.length) {
        filterButtons.forEach((button) => {
            button.addEventListener("click", () => {
                const selectedFilter = button.dataset.filter;

                filterButtons.forEach((btn) => btn.classList.remove("active"));
                button.classList.add("active");

                projectCards.forEach((card) => {
                    const categories = card.dataset.category.split(" ");

                    if (selectedFilter === "all" || categories.includes(selectedFilter)) {
                        card.style.display = "block";
                    } else {
                        card.style.display = "none";
                    }
                });
            });
        });
    }

    // image lightbox code
    const lightboxImages = document.querySelectorAll(
        ".hero-featured-art img, .project-detail-cover img, .breakdown-item img"
    );

    if (lightboxImages.length) {
        const lightbox = document.createElement("div");
        lightbox.className = "lightbox";
        lightbox.setAttribute("role", "dialog");
        lightbox.setAttribute("aria-modal", "true");
        lightbox.setAttribute("aria-label", "Enlarged portfolio image");
        lightbox.setAttribute("aria-hidden", "true");

        lightbox.innerHTML = `
            <button
                class="lightbox-close"
                type="button"
                aria-label="Close enlarged image"
            >
                &times;
            </button>

            <img class="lightbox-content" src="" alt="">
        `;

        document.body.appendChild(lightbox);

        const lightboxContent = lightbox.querySelector(".lightbox-content");
        const closeButton = lightbox.querySelector(".lightbox-close");
        let lastFocusedImage = null;

        const openLightbox = (image) => {
            lastFocusedImage = image;
            lightboxContent.src = image.currentSrc || image.src;
            lightboxContent.alt = image.alt || "Enlarged portfolio image";

            lightbox.classList.add("show");
            lightbox.setAttribute("aria-hidden", "false");
            document.body.classList.add("lightbox-open");

            closeButton.focus();
        };

        const closeLightbox = () => {
            lightbox.classList.remove("show");
            lightbox.setAttribute("aria-hidden", "true");
            document.body.classList.remove("lightbox-open");

            lightboxContent.src = "";
            if (lastFocusedImage) {
                lastFocusedImage.focus();
                lastFocusedImage = null;
            }
        };

        lightboxImages.forEach((image) => {
            image.classList.add("lightbox-trigger");
            image.setAttribute("tabindex", "0");
            image.setAttribute("role", "button");
            image.setAttribute("aria-label", `${image.alt}. Open larger image.`);

            image.addEventListener("click", () => {
                openLightbox(image);
            });

            image.addEventListener("keydown", (event) => {
                if (event.key === "Enter" || event.key === " ") {
                    event.preventDefault();
                    openLightbox(image);
                }
            });
        });

        closeButton.addEventListener("click", closeLightbox);

        lightbox.addEventListener("click", (event) => {
            if (event.target === lightbox) {
                closeLightbox();
            }
        });

        document.addEventListener("keydown", (event) => {
            if (
                event.key === "Escape" &&
                lightbox.classList.contains("show")
            ) {
                closeLightbox();
            }
        });
    }
});

